require 'rails_helper'

RSpec.describe "requried fields must be filled out to edit discounts" do

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

    @tenofften = @dog_shop.discounts.create(name: "10 off 10", description: "10% off an item when you order 10 of them!", amount: 10, quantity: 10 )
  end

  it "must have a name" do
    visit "/merchant/discounts"

    click_link "Edit Discount"

    fill_in "Name", with: ""

    click_button "Update Discount"

    expect(current_path).to eq("/merchant/discounts/#{@tenofften.id}/edit")

    expect(page).to have_content("Name can't be blank")
  end

  it "amount and quantity must be numbers" do
    visit "/merchant/discounts"

    click_link "Edit Discount"

    fill_in "Name", with: "10 off 10"
    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "a"
    fill_in "Quantity", with: "b"

    click_button "Update Discount"

    expect(current_path).to eq("/merchant/discounts/#{@tenofften.id}/edit")

    expect(page).to have_content("Amount is not a number and Quantity is not a number")
  end

  it "amount must be between 0 and 100" do
    visit "/merchant/discounts"

    click_link "Edit Discount"

    fill_in "Name", with: "10 off 10"
    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "-5"
    fill_in "Quantity", with: "10"

    click_button "Update Discount"

    expect(current_path).to eq("/merchant/discounts/#{@tenofften.id}/edit")

    expect(page).to have_content("Amount must be greater than or equal to 0")

    fill_in "Name", with: "10 off 10"
    fill_in "Description", with: "10% off an item when you order 10 of them!"
    fill_in "Amount", with: "200"
    fill_in "Quantity", with: "10"

    click_button "Update Discount"

    expect(current_path).to eq("/merchant/discounts/#{@tenofften.id}/edit")

    expect(page).to have_content("Amount must be less than or equal to 100")
  end
end
