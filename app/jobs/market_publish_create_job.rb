# Documentation
class MarketPublishCreateJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    if args[:publish].market_item_id.nil?
      MarketPublishCreateService.new(user: args[:user], publish: args[:publish]).publishing
    else
      MarketPublishEditingService.new(user: args[:user], publish: args[:publish]).editing
    end
  end
end
