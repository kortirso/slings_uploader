class ProductPublishingJob < ApplicationJob
    queue_as :default

    def perform(params)
        PublishProductsService.new({user: params[:user], product_name: params[:product_name]}).publish
    end
end
