# Documentation
class MarketPublishesCreateJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    args[:user].publishes.not_published_in_market.each do |publish|
      MarketPublishCreateService.new(user: args[:user], publish: publish, auto: true).publishing
    end
  end
end
