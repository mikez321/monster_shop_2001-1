class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.all
  end

  def new
    merchant = Merchant.find(current_user[:id])
    @discount = merchant.discount.create(discount_params)
  end

  def create
    discount = Discount.create(discount_params)
  end

  private

  def discount_params
    require "pry"; binding.pry
  end
end
