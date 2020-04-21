require 'rails_helper'

RSpec.describe "requried fields must be filled out to create discounts" do

  before(:each) do

    @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @dog_employee = @dog_shop.users.create(name: 'Dog Shop Employee',
                                           address: '123 Main St',
                                           city: 'Cityton',
                                           state: 'GA',
                                           zip: "98765",
                                           email: 'merchant2@example.com',
                                           password: 'password_merchant2',
                                           password_confirmation: 'password_merchant2',
                                           role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@dog_employee)

    @dog_food = @dog_shop.items.create(name: "Bag o Food", description: "Nutrition in bulk", price: 54, image: "https://s7d2.scene7.com/is/image/PetSmart/5149892", inventory: 32)
    @collar = @dog_shop.items.create(name: "Dog Collar", description: "Choker", price: 18, image: "https://s7d2.scene7.com/is/image/PetSmart/5169886", inventory: 32)
    @brush = @dog_shop.items.create(name: "Dog Brush", description: "Detangle those curls", price: 12, image: "https://s7d2.scene7.com/is/image/PetSmart/5280398", inventory: 32)

  end

  it "must have a name" do
    visit "/merchant/discounts"

    click_link "Add a Discount"

    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "10"
    fill_in "Quantity", with: "10"

    click_button "Create Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    expect(page).to have_content("Name can't be blank")
  end

  it "amount and quantity must be numbers" do
    visit "/merchant/discounts"

    click_link "Add a Discount"

    fill_in "Name", with: "10 off 10"
    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "a"
    fill_in "Quantity", with: "b"

    click_button "Create Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    expect(page).to have_content("Amount is not a number and Quantity is not a number")
  end

  it "amount must be between 0 and 100" do
    visit "/merchant/discounts"

    click_link "Add a Discount"

    fill_in "Name", with: "10 off 10"
    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "-5"
    fill_in "Quantity", with: "10"

    click_button "Create Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    expect(page).to have_content("Amount must be greater than or equal to 0")

    fill_in "Name", with: "10 off 10"
    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "200"
    fill_in "Quantity", with: "10"

    click_button "Create Discount"

    expect(current_path).to eq("/merchant/discounts/new")

    expect(page).to have_content("Amount must be less than or equal to 100")
  end
end
