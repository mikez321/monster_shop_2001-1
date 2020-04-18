class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :discount_items, dependent: :destroy
  has_many :items, through: :discount_items
end
