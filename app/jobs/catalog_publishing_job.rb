class CatalogPublishingJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    publishes = Product.create_publishes(args[:user])

    publishes.each do |publish|
      result = PublishCreatingService.new(user: args[:user], publish: publish).publishing
      publish.destroy if result.nil?
    end
  end
end
