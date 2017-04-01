class ProductsController < ApplicationController
    before_action :get_categories, only: :show

    def show
        @product = Product.friendly.find(params[:id])
    end

    def create
        PublishService.new({user: current_user, product_name: params[:product_id]}).publish
        head :ok
    end
end