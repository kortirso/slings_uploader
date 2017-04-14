require 'open-uri'

class ProductsUploadingService
    GROUP_ID = -10329309
    ALBUM_IDS = {'Слинги-рюкзаки' => 95176931, 'Май-слинги' => 93917967}

    attr_reader :user, :count, :photos_info

    def initialize(params)
        @user = params[:user]
        @count = params[:count]
    end

    def upload
        ALBUM_IDS.each do |album_name, album_id|
            get_album_info(album_id)
            handle_photos(album_name)
        end
    end

    private

    def get_album_info(album_id)
        response = VK::Photos::GetService.call({token: user.token, album_id: album_id, group_id: GROUP_ID, count: count})
        @photos_info = response['response']['items']
    end

    def handle_photos(album_name)
        category = Category.find_by(name: album_name)
        photos_info.each { |photo| create_product(photo, category.id, album_name) }
    end

    def create_product(photo_info, category_id, album_name)
        return false if photo_info['text'].empty?
        product_name = get_product_name(photo_info)
        return false if Product.find_by(name: product_name, category_id: category_id).present?
        product = Product.new name: product_name, price: get_product_price(photo_info, album_name), caption: photo_info['text'], category_id: category_id
        open(photo_info[get_max_image_link(photo_info)]) { |f| product.image = f }
        product.save
    end

    def get_product_name(photo_info)
        photo_info['text'].lines.first.chomp.split(',')[-2].strip.delete('\"')
    end

    def get_product_price(photo_info, album_name)
        price_line = photo_info['text'].lines.size > 2 ? photo_info['text'].lines[-2] : photo_info['text'].lines[-1]
        album_name == 'Слинги-рюкзаки' ? price_line.chomp.split(',')[-1].split[0] : price_line.split(' ')[0]
    end

    def get_max_image_link(product)
        product.keys.select { |k| k.split('_')[0] == 'photo' }.last
    end
end