require 'babosa'

class Product < ApplicationRecord
    extend FriendlyId

    friendly_id :slug_candidates, use: :slugged

    mount_uploader :image, ProductUploader

    belongs_to :category

    validates :name, presence: true, uniqueness: true
    validates :category_id, presence: true
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    def slug_candidates
        [:name, [:name, :id]]
    end

    def normalize_friendly_id(input)
        input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end
end
