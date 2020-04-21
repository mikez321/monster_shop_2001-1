require 'rails_helper'

RSpec.describe "Merchant To Do List", type: :feature do
  describe "as a merchant I should have a to do list on my merchant dashboard" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, inventory: 12)
      @seat = @bike_shop.items.create!(name: "Seat", description: "Cushy for your tushy.", price: 199, image: "https://www.rei.com/media/product/153242", inventory: 20)
      @pump = @bike_shop.items.create!(name: "Pump", description: "Not just hot air", price: 70, image: "https://www.rei.com/media/product/152974", inventory: 20)


      @josh = @bike_shop.users.create!(name: "Josh Tukman",

                            address: "756 Main St",
                            city: "Denver",
                            state: "Colorado",
                            zip: "80210",
                            email: "josh.t@gmail.com",
                            password: "secret_password",
                            password_confirmation: "secret_password",
                            role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@josh)
    end

    it "any items with no image will be displayed and have a link to that items edit page" do

      visit "/merchant"

      expect(page).to have_content("To Do:")

      within ".images" do
        expect(page).to have_content("The following items do not have an image:")
        expect(page).to have_link("#{@tire.name}")
        expect(page).to_not have_link("#{@seat.name}")
        expect(page).to_not have_link("#{@pump.name}")
        click_link("#{@tire.name}")
      end

      expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")
    end
  end
end
