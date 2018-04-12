require 'babosa'

class Product < ApplicationRecord
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  belongs_to :category

  has_many :publishes
  has_many_attached :images

  validates :name, :category_id, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :not_deleted, -> { where(deleted: false) }

  def slug_candidates
    [:name, [:name, :id]]
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def primary_image
    attachment = attachments.first
    attachment.nil? ? '' : attachment.image.to_s
  end

  def primary_image_small
    attachment = attachments.first
    attachment.nil? ? '' : attachment.image.for_catalog.to_s
  end

  def secondary_images
    attachments.to_a.shift
    attachments
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

  def self.create_publishes(user, publishes = [])
    prod_pub = user.publishes.published_in_vk.includes(:product).collect { |pub| pub.product }
    albums = user.albums.get_list

    (Product.all.to_a - prod_pub).each do |product|
      unless product.deleted?
        Publish.find_by(user: user, product: product).try(:destroy)
        publishes.push Publish.create product: product, user: user, album_id: albums.assoc(product.category.name)[1]
      end
    end

    publishes
  end
end
