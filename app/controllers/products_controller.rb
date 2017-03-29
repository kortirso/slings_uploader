class ProductsController < ApplicationController
    before_action :get_categories

    def show
        @product = Product.friendly.find(params[:id])
    end
end