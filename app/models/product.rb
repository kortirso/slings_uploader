require 'babosa'

class Product < ApplicationRecord
    extend FriendlyId

    friendly_id :slug_candidates, use: :slugged

    belongs_to :category

    has_many :publishes
    has_many :attachments, dependent: :destroy
    accepts_nested_attributes_for :attachments, allow_destroy: true

    validates :name, presence: true
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

    def deleted?
        deleted
    end

    def delete
        update(deleted: true)
    end

    def self.create_publishes(user, publishes = [])
        prod_pub = user.publishes.includes(:product).collect { |pub| pub.product }
        prod_all = Product.all.to_a

        albums = user.albums.get_list

        (prod_all - prod_pub).each do |product|
            publishes.push Publish.create product: product, user: user, album_id: albums.assoc(product.category.name)[1]
        end

        publishes
    end
end
