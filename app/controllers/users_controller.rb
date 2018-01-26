class UsersController < ApplicationController
  before_action :check_user, only: :show

  def index
    @last_products = Product.order(updated_at: :desc).limit(15).group_by(&:updated_at)
  end

  def show
    @vk_group = current_user.vk_group
    @vk_group.albums.build
    @vk_group.build_archive if @vk_group.archive.nil?
    @site = current_user.site
  end

  private def check_user
    render_not_found if current_user.id != params[:id].to_i
  end
end