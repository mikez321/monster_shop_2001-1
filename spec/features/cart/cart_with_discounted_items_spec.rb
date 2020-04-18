require 'rails_helper'

RSpec.describe "as a user, when I visit my cart, if I have items that qualify for discounts", type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @rusty_chain = @bike_shop.items.create(name: "Rusty Chain", description: "Its old and covered in rust.", price: 1, image: "https://thumbs.dreamstime.com/z/rusty-bicycle-chain-picture-blog-rusty-bicycle-chain-picture-blog-background-title-132179093.jpg", inventory: 1, active?:false)
    @bike_shop.discounts.create(name: "10 for 5", description: "Recieve 10% off an item when you purchase 5 or more", amount: 10, quantity: 5)

    @user = User.create!(name: "Josh Tukman",
                          address: "756 Main St.",
                          city: "Denver",
                          state: "Colorado",
                          zip: "80209",
                          email: "josh.t@gmail.com",
                          password: "secret_password",
                          password_confirmation: "secret_password",
                          role: 0)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    5.times do
      visit "items/#{@chain.id}"
      click_on "Add To Cart"
    end

    visit "items/#{@rusty_chain.id}"
    click_on "Add To Cart"

  end

  # it "I see a message saying that I have items that qualify for discounts" do
  #
  #   visit "/cart"
  #
  #   within "#cart-item-#{@chain.id}" do
  #     expect(page).to have_content("This item qualifies for a bulk discount!")
  #   end
  # end
end
