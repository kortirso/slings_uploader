# Documentation
class CatalogMarketingJob < ApplicationJob
  queue_as :default

  def perform(params)
    params[:user].publishes.includes(:product).not_published_in_market.references(:products).each do |publish|
      MarketPublishCreatingService.new(user: params[:user], publish: publish, auto: true).publishing
    end
  end
end
