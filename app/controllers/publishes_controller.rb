class PublishesController < ApplicationController
    before_action :find_product, only: [:create, :destroy]
    before_action :find_publish, only: [:show, :update, :destroy]

    def show
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
            PublishCreatingJob.perform_later({user: current_user, publish: @publish})
            if params[:to_market].present? && params[:to_market] == '1'
                MarketPublishCreatingJob.perform_later({user: current_user, publish: @publish})
            end
        end
        redirect_to product_publish_path(@publish.product, @publish)
    end

    def destroy
        PublishDeletingJob.perform_later({user: current_user, publish: @publish})
        @publish.destroy
        redirect_to @product
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