require 'babosa'

class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged

  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def self.get_list
    all.collect { |category| [category.name, category.id] }
  end
end
