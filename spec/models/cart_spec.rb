require 'rails_helper'

RSpec.describe Cart do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @bike_shop.discounts.create(name: "10 for 5", description: "Recieve 10% off an item when you purchase 5 or more", amount: 10, quantity: 5)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @rusty_chain = @bike_shop.items.create(name: "Rusty Chain", description: "Its old and covered in rust.", price: 1, image: "https://thumbs.dreamstime.com/z/rusty-bicycle-chain-picture-blog-rusty-bicycle-chain-picture-blog-background-title-132179093.jpg", inventory: 1, active?:false)
    @cart = Cart.new({
      @chain.id.to_s => 4,
      @rusty_chain.id.to_s => 1
    })
    @discount_cart = Cart.new({
      @chain.id.to_s => 5,
      @rusty_chain.id.to_s => 1
    })
  end

  describe "instance methods" do
    it "contents" do
      expected = {
        @chain.id.to_s => 4,
        @rusty_chain.id.to_s => 1
      }

      expect(@cart.contents).to eq(expected)
    end

    it "total_items" do
      expect(@cart.total_items).to eq(5)
    end

    it "total" do
      expect(@cart.total).to eq(201)
    end

    it "quantity_zero" do
      expect(@cart.quantity_zero?(@rusty_chain)).to eq(false)
    end

    it "has_discounts" do
      expect(@cart.has_discounts?).to eq(false)

      expect(@discount_cart.has_discounts?).to eq(true)
    end


  end
end
