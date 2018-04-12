class CatalogPublishingJob < ApplicationJob
  queue_as :default

  def perform(params)
    publishes = Product.create_publishes(params[:user])

    publishes.each do |publish|
      result = PublishCreatingService.new(user: params[:user], publish: publish).publishing
      publish.destroy if result.nil?
    end
  end
end
