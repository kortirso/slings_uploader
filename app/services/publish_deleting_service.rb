# delete publish from photos
class PublishDeletingService
  attr_reader :user, :publish

  def initialize(params)
    @user = params[:user]
    @publish = params[:publish]
  end

  def deleting
    publish.attachments.where.not(photo_id: nil).each do |a|
      VK::Photos::MoveService.call(token: user.token, owner_id: user.vk_group.group_id, photo_id: a.photo_id, target_album_id: user.vk_group.archive.identifier)
    end
  end
end
