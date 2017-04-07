class Publish < ApplicationRecord
    mount_uploader :image, ProductUploader
    
    belongs_to :user
    belongs_to :product
    belongs_to :album

    validates :user_id, :product_id, presence: true

    scope :for_user, -> (user) { find_by user: user }

    after_create :fill_publish

    private

    def fill_publish
        self.name = product.name
        self.caption = product.caption
        self.price = product.price
        File.open("#{Rails.root}/public#{self.product.image.to_s}") { |f| self.image = f }
        self.save
        Rails.logger.debug "1 - #{self.name}, 2 - #{self.price}, 3 - #{self.image.to_s}"
    end
end
