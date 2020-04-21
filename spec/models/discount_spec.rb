require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :discount_items}
    it {should have_many(:items).through :discount_items}
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :quantity }
  end
end
