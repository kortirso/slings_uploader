# Create elements for market in VK
class MarketPublishCreateService
  CATEGORY_ID = 104

  attr_reader :user, :publish, :auto, :main_photo_id

  def initialize(args = {})
    @user = args[:user]
    @publish = args[:publish]
    @auto = args[:auto]
  end

  def publishing
    return false if upload_hash['error'].present?
    save_image
    add_product_to_market
  rescue
    false
  end

  private def upload_url
    @upload_url ||= VK::Photos::GetMarketUploadServerService.call(token: user.token, group_id: user.vk_group.identifier)['response']['upload_url']
  end

  private def upload_hash
    @upload_hash = VK::Photos::MarketUploadImageService.call(upload_url: upload_url, image_content: publish.product.image_source, temp_name: "#{user.id}-#{publish.id}.jpg")
  end

  private def save_image
    response = VK::Photos::SaveMarketPhotoService.call(token: user.token, group_id: user.vk_group.identifier, caption: publish.caption, server: upload_hash['server'], photo: upload_hash['photo'], hash: upload_hash['hash'], crop_data: upload_hash['crop_data'], crop_hash: upload_hash['crop_hash'])
    @main_photo_id = response['response'][0]['id']
  end

  private def add_product_to_market
    response = VK::Market::AddService.call(token: user.token, owner_id: user.vk_group.identifier, description: publish.caption, name: name_for_publish, category_id: CATEGORY_ID, price: publish.price, main_photo_id: main_photo_id)
    publish.update(market_item: response['response']['market_item_id'])
  end

  private def name_for_publish
    auto.nil? ? publish.name : "#{publish.product.category.name} #{publish.name}"
  end
end
