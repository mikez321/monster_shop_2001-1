# Monster Shop Group Project

The Monster Shop project is an interactive shopping website that allows a users to do different things, depending on their roles:
* Default Users can view and order items. Once items have been ordered, they can view those orders and their statuses and/or cancel orders, depending on each order's status.
* Merchant Employee Users can view and update inventory for their shop and manage orders for their items.
* Admin Users can view and manage default users, merchant employee users, and all items and orders.

## How to Clone Project to Local Machine
Use the instructions below in combination with your terminal in order to learn more about this project:

  1. Clone this repository:
    ```https://github.com/mikez321/monster_shop_2001-Group```

  2. Install the necessary gems:
    ```bundle install``` &
    ```bundle update```

  3. Initialize the database:
    ```rails db:{create,migrate,seed}```

  4. Make a connection with the Rails server:
    ```rails s```

  5. Visit your browser, and enter the following into the search bar:
  ```localhost:3000```

  6. Enjoy!

## Skills Gained from this Project

### Rails
* Create routes for namespaced routes
* Implement partials to break a page into reusable components
* Use Sessions to store information about a user and implement login/logout functionality
* Use filters (e.g. `before_action`) in a Rails controller
* Limit functionality to authorized users
* Use BCrypt to hash user passwords before storing in the database

### ActiveRecord
* Use built-in ActiveRecord methods to join multiple tables of data, calculate statistics and build collections of data grouped by one or more attributes

### Databases
* Design and diagram a Database Schema
* Write raw SQL queries (as a debugging tool for AR)

### Testing and Debugging
* Write feature tests utilizing:
  - RSpec and Capybara
  - CSS selectors to target specific areas of a page
  - Use Pry in Rails files to get more information about an error
  - Use `save_and_open_page` to view the HTML generated when visiting a path in a feature test
  - Utilize the Rails console as a tool to get more information about the current state of a development database
  - Use `rails routes` to get additional information about the routes that exist in a Rails application

### Visual Representation of the Schema
![schema visual](https://raw.githubusercontent.com/kmcgrevey/monster_shop_2001/master/app/assets/images/Screen%20Shot%202020-04-16%20at%2010.45.07%20AM.png)

## Link to Application in Production
* https://jkkm-monster-shop.herokuapp.com/

## Links to Contributor Github Profiles
* Josh Tukman: https://github.com/Joshua-Tukman
* Kevin McGrevey: https://github.com/kmcgrevey
* Krista Stadler:  https://github.com/kristastadler
* Mike Hernandez: https://github.com/mikez321

### Update!  Added functionality!

* As of 4/17 important changes to this repo were made to allow for bulk discounts.  Changes adhere to to the following user stories:

* Bulk Items Discount Landing Page:

As a merchant employee, when I visit my merchant dashboard I see a link to "My Discounts."  When I click this link I am brought to my discounts page /merchant/discounts where I can see my discounts.  If I do not any discounts I see a message that says "You have no discounts."

* Add a Discount:

As a merchant employee, when I am at my discounts page I see a link to Add a discount.  When I click this link I am brought to a page where I can create a custom discount.  When I click on the "Save Discount" button I am brought back to my discounts page where I see my new discount.  I also see a flash message saying that I have added a discount.

* Users see discounts:

As a user, when I have added items in my cart that qualify for a merchant's discount I see that discount reflected on the applicable item in my cart.  No other items have discounts except ones that meet requirements.

* Users see discounts ctd:

As a user, if I have a discount on an item and then reach a better discount, I am given the better of the two discounts.

* Edit a Discount:

As a merchant employee, when I visit my discounts, I see a link next to each discount to edit the discount.  Here I am able to change parameters of the bulk discount.  I see a button to submit changes and when I click the button I am redirected to the discount page where I see my new changes to my discount.  I see a flash message telling me that my discount was successfully updated.

* Delete a discount:

As a merchant employee, when I visit my discount page, I see a link next to each discount to delete the discount.  When I click the link I see a flash message telling me that my discount was successfully deleted and it is no longer in my discount list.  Users will no longer be able to access this discount.
