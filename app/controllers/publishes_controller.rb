class PublishesController < ApplicationController
    before_action :find_product, only: :create
    before_action :find_publish, only: :update

    def show
        @publish = Publish.find_by(id: params[:id])
        @albums = current_user.albums.get_list
    end

    def create
        publish = Publish.new product: @product, user: current_user
        if publish.save
            redirect_to product_publish_path(@product, publish)
        else
            redirect_to @product
        end
    end

    def update
        if @publish.update(publish_params)
            ProductPublishingJob.perform_later({user: current_user, publish: @publish})
        end        
    end

    private

    def find_product
        @product = Product.friendly.find(params[:product_id])
    end

    def find_publish
        @publish = Publish.find_by(id: params[:id])
    end

    def publish_params
        params.require(:publish).permit(:name, :caption, :price, :album_id)
    end
end