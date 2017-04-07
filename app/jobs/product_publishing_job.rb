class ProductPublishingJob < ApplicationJob
    queue_as :default

    def perform(params)
        PublishProductsService.new({user: params[:user], publish: params[:publish]}).publishing
    end
end
