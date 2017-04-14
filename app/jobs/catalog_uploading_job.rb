class CatalogUploadingJob < ApplicationJob
    queue_as :default

    def perform(params)
        ProductsUploadingService.new({user: params[:user], count: ''}).upload
    end
end