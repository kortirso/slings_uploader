# Create publishes in VK
class PublishCreatingService
  attr_reader :user, :publish, :photo_url

  def initialize(params)
    @user = params[:user]
    @publish = params[:publish]
    @photo_url = publish.product.image_url
  end

  def publishing
    return nil if upload_hash['error'].present?
    save_image
    update_publish
  rescue
    nil
  end

  private def upload_url
    @upload_url ||= VK::Photos::GetUploadServerService.call(token: user.token, album_id: publish.album_id, group_id: user.vk_group.group_id)['response']['upload_url']
  end

  private def upload_hash
    @upload_hash ||= VK::Photos::UploadImageService.call(upload_url: upload_url, image_path: photo_url)
  end

  private def save_image
    VK::Photos::SaveService.call(token: user.token, album_id: publish.album_id, group_id: user.vk_group.group_id, caption: publish.caption, server: upload_hash['server'], photos_list: upload_hash['photos_list'], hash: upload_hash['hash'])
    # publish.attachments.create photo_id: response['response'][0]['id'], parent: photo
  end

  private def update_publish
    publish.update(published: true)
  end
end
