class Publish < ApplicationRecord
    mount_uploader :image, ProductUploader
    
    belongs_to :user
    belongs_to :product
    belongs_to :album

    validates :user_id, :product_id, presence: true

    scope :for_user, -> (user) { find_by user: user }

    after_create :fill_publish

    def product_image
        product.image
    end

    private

    def fill_publish
        self.name = product.name
        self.caption = product.caption
        self.price = product.price
        self.save
    end
end
