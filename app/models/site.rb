# Represents sites for integration
class Site < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
end
