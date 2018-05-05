# Documentation
class MarketPublishesCreateJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    publishes(args[:user]).each do |publish|
      MarketPublishCreateService.new(user: args[:user], publish: publish, auto: true).publishing
    end
  end

  private def publishes(user)
    user.publishes.includes(:product).not_published_in_market.references(:products)
  end
end
