class ProductsController < ApplicationController
    before_action :get_categories, only: :show
    before_action :check_admin_role, except: [:show, :mass_inserting]
    before_action :find_product, only: [:show, :edit, :update, :destroy]

    def show
        @publish = @product.publishes.find_by(user_id: current_user.id)
    end

    def new
        @categories = Category.get_list
    end

    def create
        product = Product.new(product_params)
        if product.save
            redirect_to product
        else
            render :new
        end
    end

    def edit
        @categories = Category.get_list
    end

    def update
        if @product.update(product_params)
            redirect_to @product
        else
            render :edit
        end
    end

    def destroy
        @product.destroy
        redirect_to products_path
    end

    def mass_inserting
        CatalogPublishingJob.perform_later({user: current_user})
    end

    private

    def find_product
        @product = Product.friendly.find(params[:id])
    end

    def check_admin_role
        render template: 'shared/404', status: 404 unless current_user.is_admin?
    end

    def product_params
        params.require(:product).permit(:name, :caption, :price, :category_id, :image)
    end
end