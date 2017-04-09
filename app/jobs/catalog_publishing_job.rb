class CatalogPublishingJob < ApplicationJob
    queue_as :default

    def perform(params)
        publishes = Product.create_publishes(params[:user])

        publishes.each do |publish|
            PublishProductsService.new({user: params[:user], publish: publish}).publishing
        end
    end
end
