class CategoriesController < ApplicationController
    before_action :get_categories
    before_action :find_category, only: :show

    def index
        @products = Product.order(updated_at: :desc).includes(:publishes, :attachments)
    end    

    def show
        @products = @category.products.order(updated_at: :desc).includes(:publishes, :attachments)
    end

    private

    def find_category
        @category = Category.friendly.find(params[:id])
        render_not_found if @category.nil?
    end
end