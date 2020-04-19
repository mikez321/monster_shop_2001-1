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

  it "I see a message saying that I have items that qualify for discounts" do

    visit "/cart"

    expect(page).to have_content "You have discounted items in your cart!"
  end

  it "Items that have bulk discounts are discounted in my cart automatically" do
    visit "/cart"

    within "#cart-item-#{@chain.id}" do
      expect(page).to have_content("This item qualifies for a discount!")
      expect(page).to have_content("#{@chain.price}")
      expect(page).to have_content("New Price: $45.00")
    end

    within "#cart-item-#{@rusty_chain.id}" do
      expect(page).to_not have_content("This item qualifies for a discount!")
      expect(page).to have_content("#{@rusty_chain.price}")
      expect(page).to_not have_content("New Price:")
    end
  end

  it "Only items from vendors with discounts get the item discount" do

    kitchen_shop = Merchant.create(name: "The Bake Place", address: '117 Cake St.', city: 'Richmond', state: 'VA', zip: 23221)
    corn_holder = kitchen_shop.items.create(name: "OXO Corn Holders", description: "Good for corny jokes", price: 10, image: "https://www.surlatable.com/dw/image/v2/BCJL_PRD/on/demandware.static/-/Sites-shop-slt-master-catalog/default/dw66439aea/images/large/1473222_01i_0414_s.jpg", inventory: 50)

    5.times do
      visit "items/#{corn_holder.id}"
      click_on "Add To Cart"
    end

    visit "/cart"

    within "#cart-item-#{@chain.id}" do
      expect(page).to have_content("This item qualifies for a discount!")
      expect(page).to have_content("#{@chain.price}")
      expect(page).to have_content("New Price: $45.00")
    end

    within "#cart-item-#{corn_holder.id}" do
      expect(page).to_not have_content("This item qualifies for a discount!")
      expect(page).to_not have_content("New Price:")
    end
  end

  it "if multiple discounts exist the lowest price is applied" do
    bogf = @bike_shop.discounts.create(name: "Insane Deals!", description: "Get a ridiculously good deal when you buy 7", amount: 90, quantity: 7)

    visit "/cart"

    within "#cart-item-#{@chain.id}" do
      expect(page).to have_content("This item qualifies for a discount!")
      expect(page).to have_content("#{@chain.price}")
      expect(page).to have_content("New Price: $45.00")
    end

    2.times do
      visit "items/#{@chain.id}"
      click_on "Add To Cart"
    end

    visit "/cart"

    within "#cart-item-#{@chain.id}" do
      expect(page).to have_content("This item qualifies for a discount!")
      expect(page).to have_content("#{@chain.price}")
      expect(page).to_not have_content("New Price: $45.00")
      expect(page).to have_content("New Price: $5.00")
    end
  end

  # it "an item will automatically be returned to regular price if bulk conditions are not met" do
  #   visit "/cart"
  #
  #   within "#cart-item-#{@chain.id}" do
  #     expect(page).to have_content("This item qualifies for a discount!")
  #     expect(page).to have_content("#{@chain.price}")
  #     expect(page).to have_content("New Price: $45.00")
  #     click_button "Subtract Qty"
  #   end
  #
  #   within "#cart-item-#{@chain.id}" do
  #     expect(page).to_not have_content("This item qualifies for a discount!")
  #     expect(page).to have_content("#{@chain.price}")
  #     expect(page).to_not have_content("New Price: $45.00")
  #   end
  #
  # end

  it "subtotal reflects discount price" do

    visit "/cart"

    within "#cart-item-#{@chain.id}" do
      expect(page).to_not have_content("250.00")
      expect(page).to have_content("$225.00")
    end
  end

  it "checkout has discounted total" do
    visit "/cart"

    expect(page).to have_content("Total: $226.00")
    expect(page).to_not have_content("Total: $251.00")
  end
end
