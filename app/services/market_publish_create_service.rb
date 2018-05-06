# Create elements for market in VK
class MarketPublishCreateService
  CATEGORY_ID = 104

  attr_reader :user, :publish, :auto, :client, :market_client, :main_photo_id, :filename

  def initialize(args = {})
    @user = args[:user]
    @publish = args[:publish]
    @auto = args[:auto]
    @client = VkApiSimple::Photos.new(token: user.token)
    @market_client = VkApiSimple::Market.new(token: user.token)
  end

  def publishing
    create_temp_file
    return false if upload_hash['error'].present?
    save_image
    delete_temporary_file
    add_product_to_market
  rescue
    false
  end

  private def upload_url
    @upload_url ||= client.get_market_upload_server(group_id: user.vk_group.identifier)['response']['upload_url']
  end

  private def upload_hash
    @upload_hash ||= client.upload_image(url: upload_url, filename: filename)
  end

  private def save_image
    @main_photo_id = client.save_market_photo(group_id: user.vk_group.identifier, server: upload_hash['server'], photo: upload_hash['photo'], hash: upload_hash['hash'], crop_data: upload_hash['crop_data'], crop_hash: upload_hash['crop_hash'])['response'][0]['id']
  end

  private def add_product_to_market
    response = market_client.add(owner_id: user.vk_group.identifier, description: publish.caption, name: name_for_publish, category_id: CATEGORY_ID, price: publish.price, main_photo_id: main_photo_id)
    publish.update(market_item: response['response']['market_item_id'])
  end

  private def create_temp_file
    @filename = "#{Rails.root}/tmp/#{user.id}-#{publish.id}.jpg"
    File.open(filename, 'wb') { |f| f.write(publish.product.image_source) }
  end

  private def delete_temporary_file
    File.delete(filename)
  end

  private def name_for_publish
    auto.nil? ? publish.name : "#{publish.product.category.name} #{publish.name}"
  end
end
