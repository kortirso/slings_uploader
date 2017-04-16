class CatalogMarketingJob < ApplicationJob
    queue_as :default

    def perform(params)
        params[:user].publishes.where(market_item_id: nil).each do |publish|
            MarketPublishCreatingService.new({user: params[:user], publish: publish, auto: true}).publishing
        end
    end
end
