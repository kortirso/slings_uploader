class CategoriesController < ApplicationController
    before_action :get_categories
    before_action :find_category, only: :show

    def index
        @products = Product.order(updated_at: :desc).includes(:attachments)
        @publishes = current_user.publishes.pluck(:product_id)
    end    

    def show
        @products = @category.products.order(updated_at: :desc).includes(:attachments)
        @publishes = current_user.publishes.pluck(:product_id)
    end

    private

    def find_category
        @category = Category.friendly.find(params[:id])
        render_not_found if @category.nil?
    end
end