class Attachment < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :product
  belongs_to :parent, class_name: 'Attachment'
end
