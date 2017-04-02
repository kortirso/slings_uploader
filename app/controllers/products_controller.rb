class ProductsController < ApplicationController
    before_action :get_categories, only: :show

    def show
        @product = Product.friendly.find(params[:id])
    end

    def create
        ProductPublishingJob.perform_later({user: current_user, product_name: params[:product_id]})
        head :ok
    end
end