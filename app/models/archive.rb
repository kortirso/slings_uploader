# Represents archives for deleted photos
class Archive < ApplicationRecord
  belongs_to :vk_group

  validates :vk_group_id, presence: true

  def set?
    identifier.present?
  end
end
