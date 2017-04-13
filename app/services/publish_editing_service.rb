class PublishEditingService
    attr_reader :user, :publish

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
    end

    def editing
        response = VK::Photos::EditService.call({token: user.token, owner_id: user.vk_group.group_id, photo_id: publish.photo_id, caption: publish.caption})
    end
end