class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update mass_inserting marketing destroy]
  before_action :select_categories, only: %i[show]
  before_action :check_admin_role, except: %i[show mass_inserting marketing]
  before_action :find_product, only: %i[show edit update destroy]
  before_action :find_category, only: %i[create]
  before_action :select_categories_names, only: %i[new edit]

  def show
    @publish = @product.publishes.find_by(user_id: current_user.id)
  end

  def new; end

  def create
    product = @category.products.new(product_params)
    if product.save
      redirect_to product
    else
      redirect_to new_product_path
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product.delete
    redirect_to @product
  end

  def mass_inserting
    if current_user.with_albums?
      GroupPublishesCreateJob.perform_later(user: current_user)
    end
  end

  def marketing
    MarketPublishesCreateJob.perform_later(user: current_user)
  end

  private def find_product
    @product = Product.friendly.find(params[:id])
    render_not_found if @product.nil?
  end

  private def find_category
    @category = Category.find_by(id: params[:product][:category_id])
    redirect_to new_product_path if @category.nil?
  end

  private def product_params
    params.require(:product).permit(:name, :caption, :price, :image)
  end

  private def select_categories_names
    @categories = Category.list
  end
end
