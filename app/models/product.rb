require 'babosa'

class Product < ApplicationRecord
    extend FriendlyId

    friendly_id :slug_candidates, use: :slugged

    mount_uploader :image, ProductUploader

    belongs_to :category

    has_many :publishes

    validates :name, presence: true, uniqueness: true
    validates :category_id, presence: true
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    def slug_candidates
        [:name, [:name, :id]]
    end

    def normalize_friendly_id(input)
        input.to_s.to_slug.normalize(transliterations: :russian).to_s
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
