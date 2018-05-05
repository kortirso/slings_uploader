# Create publishes in VK
class GroupPublishCreateService
  attr_reader :user, :publish

  def initialize(args = {})
    @user = args[:user]
    @publish = args[:publish]
  end

  def publishing
    return destroy_publish if upload_hash['error'].present?
    save_image
  rescue
    destroy_publish
  end

  private def upload_url
    @upload_url ||= VK::Photos::GetUploadServerService.call(token: user.token, album_id: publish.vk_item, group_id: user.vk_group.identifier)['response']['upload_url']
  end

  private def upload_hash
    @upload_hash ||= VK::Photos::UploadImageService.call(upload_url: upload_url, image_content: publish.product.image_source, temp_name: "#{user.id}-#{publish.id}.jpg")
  end

  private def save_image
    response = VK::Photos::SaveService.call(token: user.token, album_id: publish.vk_item, group_id: user.vk_group.identifier, caption: publish.caption, server: upload_hash['server'], photos_list: upload_hash['photos_list'], hash: upload_hash['hash'])
    publish.update(published: true, vk_photo_identifier: response['response'][0]['id'])
  end

  private def destroy_publish
    publish.destroy
  end
end
