class CategoriesController < ApplicationController
    before_action :get_categories

    def index
        @products = Product.order(updated_at: :desc).includes(:publishes, :attachments)
    end    

    def show
        @category = Category.friendly.find(params[:id])
        @products = @category.products.order(updated_at: :desc).includes(:publishes, :attachments)
    end
end