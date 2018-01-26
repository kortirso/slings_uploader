class CatalogMarketingJob < ApplicationJob
  queue_as :default

  def perform(params)
    params[:user].publishes.includes(:product).not_published_in_market.where('products.category_id != ?', Category.find_by(name: 'Ткани').id).references(:products).each do |publish|
      MarketPublishCreatingService.new({user: params[:user], publish: publish, auto: true}).publishing
    end
  end
end
