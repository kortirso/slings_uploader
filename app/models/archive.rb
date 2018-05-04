# Represents archives for deleted photos
class Archive < ApplicationRecord
  belongs_to :vk_group

  validates :vk_group, presence: true

  def set?
    identifier.present?
  end
end
