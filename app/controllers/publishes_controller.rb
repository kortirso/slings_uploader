class PublishesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :find_product, only: %i[create destroy]
  before_action :find_publish, only: %i[show update destroy]
  before_action :check_publish, only: %i[show]

  def show
    @albums = current_user.albums.list
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
    PublishCreatingJob.perform_later(user: current_user, publish: @publish, photos_check: params[:photos_check]) if params[:to_vk].present? && @publish.update(publish_params)
    MarketPublishCreatingJob.perform_later(user: current_user, publish: @publish) if params[:to_market].present?
    SitePublishCreatingJob.perform_later(user: current_user, publish: @publish, album_id: publish_params[:album_id]) if params[:to_site].present?
    redirect_to @publish.product
  end

  def destroy
    PublishDeletingService.new(user: current_user, publish: @publish).deleting if @publish.album_id.present?
    MarketPublishDeletingService.new(user: current_user, publish: @publish).deleting if @publish.market_item_id.present?
    SitePublishCreatingService.new(user: current_user, publish: @publish).destroy if @publish.site_item_id.present?
    @publish.destroy
    redirect_to @product
  end

  private def find_product
    @product = Product.friendly.find(params[:product_id])
    render_not_found if @product.nil?
  end

  private def find_publish
    @publish = Publish.find_by(id: params[:id])
    render_not_found if @publish.nil?
  end

  private def check_publish
    render_not_found if current_user.id != @publish.user_id
  end

  private def publish_params
    params.require(:publish).permit(:name, :caption, :price, :album_id)
  end
end
