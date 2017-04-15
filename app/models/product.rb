require 'babosa'

class Product < ApplicationRecord
    extend FriendlyId

    friendly_id :slug_candidates, use: :slugged

    belongs_to :category

    has_many :publishes
    has_many :attachments, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    validates :name, presence: true#, uniqueness: true
    validates :category_id, presence: true
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    def slug_candidates
        [:name, [:name, :id]]
    end

    def normalize_friendly_id(input)
        input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end

    def primary_image
        attachment = attachments.first
        attachment.nil? ? nil : attachment.image.to_s
    end

    def primary_image_small
        attachment = attachments.first
        attachment.nil? ? nil : attachment.image.for_catalog.to_s
    end

    def secondary_images
        attachments.to_a.shift
        attachments
    end

    def self.create_publishes(user)
        Publish.where(user: user).destroy_all
        albums = user.albums.get_list

        all.each do |product|
            Publish.create product: product, user: user, album_id: albums.assoc(product.category.name)[1]
        end

        Publish.where(user: user)
    end
end
