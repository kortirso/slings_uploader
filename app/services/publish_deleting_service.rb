class PublishDeletingService
    attr_reader :user, :publish

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
    end

    def deleting
        response = VK::Photos::DeleteService.call({token: user.token, owner_id: user.vk_group.group_id, photo_id: publish.photo_id})
    end
end