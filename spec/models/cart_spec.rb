require 'rails_helper'

RSpec.describe Cart do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @rusty_chain = @bike_shop.items.create(name: "Rusty Chain", description: "Its old and covered in rust.", price: 1, image: "https://thumbs.dreamstime.com/z/rusty-bicycle-chain-picture-blog-rusty-bicycle-chain-picture-blog-background-title-132179093.jpg", inventory: 1, active?:false)
    @cart = Cart.new({
      @chain.id => 4,
      @rusty_chain.id => 1
    })
  end

  describe "instance methods" do
    it "contents" do
      expected = {
        @chain.id => 4,
        @rusty_chain.id => 1
      }

      expect(@cart.contents).to eq(expected)
    end

    it "total_items" do
      expect(@cart.total_items).to eq(5)
    end


  end
end
