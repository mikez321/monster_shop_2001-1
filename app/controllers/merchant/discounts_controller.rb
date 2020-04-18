class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.all
  end

  def new
    merchant = Merchant.find(current_user[:merchant_id])
    @discount = merchant.discounts.new
  end

  def create
    merchant = Merchant.find(current_user[:merchant_id])
    if merchant.discounts.create(discount_params)
      redirect_to "/merchant/discounts"
    end
  end

  private

  def discount_params
    params[:discount].permit(:name, :description, :amount, :quantity)
  end
end
