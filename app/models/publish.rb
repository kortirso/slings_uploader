# Represents publishes for products for different users
class Publish < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_one_attached :image

  validates :user_id, :product_id, presence: true

  scope :published_in_vk, -> { where(published: true) }
  scope :not_published_in_market, -> { where(market_item: nil) }

  after_create :fill_publish

  def product_image
    image.attached? ? image : product.image
  end

  def album_of_publish
    user.albums.find_by(identifier: vk_item)
  end

  private def fill_publish
    update(name: product.name, caption: product.caption, price: product.price)
  end
end
