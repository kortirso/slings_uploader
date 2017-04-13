class Archive < ApplicationRecord
    belongs_to :vk_group

    validates :vk_group_id, presence: true

    def is_set?
        album_id.present?
    end
end
