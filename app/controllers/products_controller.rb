class ProductsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :mass_inserting, :upload_all_db, :marketing, :destroy]
    before_action :get_categories, only: :show
    before_action :check_admin_role, except: [:show, :mass_inserting, :marketing]
    before_action :find_product, only: [:show, :edit, :update, :destroy]

    def show
        @publish = @product.publishes.find_by(user_id: current_user.id)
    end

    def new
        @categories = Category.get_list
        @product = Product.new
        @attachments = @product.attachments.build
    end

    def create
        product = Product.new(product_params)
        if product.save
            params['product']['attachment']['image'].each { |image| product.attachments.create(image: image) }
            redirect_to product
        else
            render :new
        end
    end

    def edit
        @categories = Category.get_list
        @attachments = @product.attachments.build
    end

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
        if current_user.with_two_albums?
            CatalogPublishingJob.perform_later({user: current_user})
            render :inserting_true
        else
            render :inserting_false
        end
    end

    def upload_all_db
        CatalogUploadingJob.perform_later({user: current_user})
        redirect_to categories_path
    end

    def marketing
        CatalogMarketingJob.perform_later({user: current_user})
        render :marketing
    end

    private

    def find_product
        @product = Product.friendly.find(params[:id])
        render_not_found if @product.nil?
    end

    def product_params
        params.require(:product).permit(:name, :caption, :price, :category_id)
    end
end