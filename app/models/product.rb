require 'babosa'

# Represents products
class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  belongs_to :category

  has_many :publishes
  has_one_attached :image

  validates :name, :category_id, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :not_deleted, -> { where(deleted: false) }

  class << self
    def create_publishes(user, publishes = [], albums = user.albums.list)
      Product.unpublished(user).each do |product|
        Publish.find_by(user: user, product: product).try(:destroy)
        publishes << Publish.create(product: product, user: user, album_id: albums.assoc(product.category.name)[1])
      end
      publishes
    end

    def unpublished(user)
      Product.not_deleted.to_a - Product.published(user)
    end

    def published(user)
      user.publishes.published_in_vk.includes(:product).collect(&:product)
    end
  end

  def slug_candidates
    [:name, [:name, :id]]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def status
    if deleted?
      'Удален'
    elsif created_at != updated_at
      'Обновлен'
    else
      'Новый'
    end
  end

  def delete
    update(deleted: true)
  end
end
