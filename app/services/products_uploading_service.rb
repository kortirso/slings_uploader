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
        photos_info.each { |photo| create_product(photo, category.id) }
    end

    def create_product(photo_info, category_id)
        product_photo_id = photo_info['id']
        product_max_image_link = photo_info[get_max_image_link(photo_info)]
        product_text = photo_info['text']
        
        product = Product.new name: product_text.split(',')[2], price: 2600, caption: product_text, category_id: category_id
        open(product_max_image_link) { |f| product.image = f }
        product.save
    end

    def get_max_image_link(product)
        product.keys.select { |k| k.split('_')[0] == 'photo' }.last
    end
end