class MarketPublishCreatingJob < ApplicationJob
    queue_as :default

    def perform(params)
        if params[:publish].market_item_id.nil?
            MarketPublishCreatingService.new({user: params[:user], publish: params[:publish]}).publishing
        end
    end
end
