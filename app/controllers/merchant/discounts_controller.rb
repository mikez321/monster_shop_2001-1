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
    discount = merchant.discounts.new(discount_params)
    if discount.save
      flash[:success] = "Discount added!"
      redirect_to "/merchant/discounts"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      flash[:success] = "Discount has been updated!"
      redirect_to "/merchant/discounts"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
      redirect_back(fallback_location: "/")
    end
  end

  def destroy
    Discount.destroy(params[:id])
    flash[:success] = "Discount has been deleted."
    redirect_to "/merchant/discounts"
  end

  private

  def discount_params
    params[:discount].permit(:name, :description, :amount, :quantity)
  end
end
