class CategoriesController < ApplicationController
  before_action :select_categories
  before_action :find_products, only: %i[index]
  before_action :find_category, only: %i[show]
  before_action :find_category_products, only: %i[show]
  before_action :find_publish_ids

  def index; end

  def show; end

  private def find_products
    @products = Product.for_catalog
  end

  private def find_category
    @category = Category.friendly.find(params[:id])
    render_not_found if @category.nil?
  end

  private def find_category_products
    @products = @category.products.for_catalog
  end

  private def find_publish_ids
    @publishes = current_user.publishes.pluck(:product_id)
  end
end
