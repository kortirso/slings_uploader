require 'open-uri'

# Create all products from VK
class ProductsUploadingService
  GROUP_ID = -10_329_309
  ALBUM_IDS = { 'Слинги-рюкзаки' => 95_176_931, 'Май-слинги' => 93_917_967, 'Ткани' => 243_920_774 }.freeze

  attr_reader :user, :photos_info, :errors

  def initialize(params)
    @user = params[:user]
    @errors = []
  end

  def upload(group)
    groups = group.nil? ? ALBUM_IDS : ALBUM_IDS.select { |k, _v| k == group }
    groups.each do |album_name, album_id|
      album_info(album_id)
      handle_photos(album_name)
    end
  rescue
    false
  end

  private def album_info(album_id)
    response = VK::Photos::GetService.call(token: user.token, album_id: album_id, group_id: GROUP_ID, count: '')
    @photos_info = response['response']['items']
  end

  private def handle_photos(album_name)
    category = Category.find_by(name: album_name)
    photos_info.each { |photo| create_product(photo, category.id, album_name) }
  end

  private def create_product(photo_info, category_id, album_name)
    return false if photo_info['text'].empty? && album_name != 'Ткани'

    product_name = select_product_name(photo_info)
    product = Product.find_by(name: product_name, category_id: category_id)
    if product.nil?
      product = Product.create! name: product_name, price: select_product_price(photo_info, album_name), caption: photo_info['text'], category_id: category_id
      product.publishes.create user: user, album_id: ALBUM_IDS[album_name], published: true
    end

    download = open(photo_info[max_image_link(photo_info)])
    temp_file = "#{Rails.root}/public/uploads/#{download.base_uri.to_s.split('/')[-1]}"
    IO.copy_stream(download, temp_file)

    File.open(temp_file) { |f| product.attachments.create photo_id: photo_info['id'], image: f }
    File.delete(temp_file)
  end

  private def select_product_name(photo_info)
    if photo_info['text'].blank?
      "Ткань_#{photo_info['id']}"
    else
      photo_info['text'].lines.first.chomp.split(',')[-2].strip.delete('\"')
    end
  end

  private def select_product_price(photo_info, album_name)
    return 0 if album_name == 'Ткани'
    price_line = photo_info['text'].lines.size > 2 ? photo_info['text'].lines[-2] : photo_info['text'].lines[-1]
    return price_line.split(' ')[0].to_i if album_name != 'Слинги-рюкзаки'
    if price_line.chomp.split(',').size == 1
      return price_line.chomp.split(' ')[-2].to_i
    else
      return price_line.chomp.split(',')[-1].split[0].to_i
    end
  end

  private def max_image_link(product)
    product.keys.select { |k| k.split('_')[0] == 'photo' }.last
  end
end
