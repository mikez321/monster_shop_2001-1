require 'rails_helper'

RSpec.describe "as a merchant employee when I visit my merchant dashboard I see a link to my discounts" do

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

  describe "when I click the link I am brought to my discounts page /merchant/discouts" do
    it "If I have no discounts, I see a message saying I have no discounts" do

      visit "/merchant/discounts"

      expect(page).to have_content("You have no discounts.")

    end
  end
end
