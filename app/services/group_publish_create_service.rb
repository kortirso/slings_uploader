require 'vk_api_simple'

# Create publishes in VK
class GroupPublishCreateService
  attr_reader :user, :publish, :client

  def initialize(args = {})
    @user = args[:user]
    @publish = args[:publish]
    @client = VkApiSimple::Photos.new(token: user.token)
  end

  def publishing
    return destroy_publish if upload_hash['error'].present?
    save_image
  rescue
    destroy_publish
  end

  private def upload_url
    @upload_url ||= client.get_upload_server(album_id: publish.vk_item, group_id: user.vk_group.identifier)['response']['upload_url']
  end

  private def upload_hash
    filename = "#{Rails.root}/tmp/#{user.id}-#{publish.id}.jpg"
    File.open(filename, 'wb') { |f| f.write(publish.product.image_source) }
    @upload_hash ||= client.upload_image(url: upload_url, filename: filename)
    File.delete(filename)
  end

  private def save_image
    response = client.save(album_id: publish.vk_item, group_id: user.vk_group.identifier, caption: publish.caption, server: upload_hash['server'], photos_list: upload_hash['photos_list'], hash: upload_hash['hash'])
    publish.update(published: true, vk_photo_identifier: response['response'][0]['id'])
  end

  private def destroy_publish
    publish.destroy
  end
end
