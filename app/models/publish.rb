class Publish < ApplicationRecord    
    belongs_to :user
    belongs_to :product
    belongs_to :album

    has_many :attachments, dependent: :destroy

    validates :user_id, :product_id, presence: true

    scope :published_in_vk, -> { where published: true }
    scope :not_published_in_market, -> { where market_item_id: nil }

    after_create :fill_publish

    def product_image
        product.primary_image
    end

    def is_published?
        published
    end

    private

    def fill_publish
        self.name = product.name
        self.caption = product.caption
        self.price = product.price
        self.save
    end
end
