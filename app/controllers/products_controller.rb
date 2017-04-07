class ProductsController < ApplicationController
    before_action :get_categories

    def show
        @product = Product.friendly.find(params[:id])
        @publish = @product.publishes.find_by(user_id: current_user.id)
    end
end