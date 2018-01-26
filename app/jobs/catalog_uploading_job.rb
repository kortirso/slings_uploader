class CatalogUploadingJob < ApplicationJob
  queue_as :default

  def perform(params)
    ProductsUploadingService.new({user: params[:user]}).upload(params[:category])
  end
end
