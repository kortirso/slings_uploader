class UsersController < ApplicationController
  def index
    @last_products = Product.order(updated_at: :desc).limit(15).group_by(&:updated_at)
  end
end