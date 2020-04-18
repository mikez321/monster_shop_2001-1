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

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
  end

  def destroy
    Discount.destroy(params[:id])
    redirect_to "/merchant/discounts"
  end

  private

  def discount_params
    params[:discount].permit(:name, :description, :amount, :quantity)
  end
end
