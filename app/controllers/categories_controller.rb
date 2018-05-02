class CategoriesController < ApplicationController
  before_action :get_categories
  before_action :find_category, only: :show

  def index
    @products = Product.not_deleted.order(updated_at: :desc).with_attached_image
    @publishes = current_user.publishes.pluck(:product_id)
  end    

  def show
    @products = @category.products.not_deleted.order(updated_at: :desc).with_attached_image
    @publishes = current_user.publishes.pluck(:product_id)
  end

  private def find_category
    @category = Category.friendly.find(params[:id])
    render_not_found if @category.nil?
  end
end