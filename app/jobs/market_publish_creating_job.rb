class MarketPublishCreatingJob < ApplicationJob
  queue_as :default

  def perform(params)
    if params[:publish].market_item_id.nil?
      MarketPublishCreatingService.new({user: params[:user], publish: params[:publish]}).publishing
    else
      MarketPublishEditingService.new({user: params[:user], publish: params[:publish]}).editing
    end
  end
end
