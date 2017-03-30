class Album < ApplicationRecord
    belongs_to :vk_group

    validates :vk_group_id, presence: true

    after_create :remove_empties

    private

    def remove_empties
        self.destroy if vk_id.nil?
    end
end
