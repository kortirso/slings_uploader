class MarketPublishDeletingService
    attr_reader :user, :publish

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
    end

    def deleting
        response = VK::Market::DeleteService.call({token: user.token, owner_id: user.vk_group.group_id, item_id: publish.market_item_id})
    end
end