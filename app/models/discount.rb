class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :discount_items, dependent: :destroy
  has_many :items, through: :discount_items

  validates_presence_of :name
  validates_presence_of :amount
  validates_presence_of :quantity
  validates_numericality_of :amount, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  validates_numericality_of :quantity
end
