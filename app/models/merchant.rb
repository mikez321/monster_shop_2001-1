class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :users
  has_many :discounts
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  enum status:{disabled: 0, enabled: 1}

  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def pending_orders
    orders = Order.joins(:items).where(:items => {:merchant_id => id})
    orders.distinct(:id)
  end

  def items_without_images
    Item.where(merchant_id: id, image: [nil, ""])
  end

  def num_pending_orders
    pending_orders.length
  end

  def pending_money
    unfulfilled = item_orders.where(status: "Unfulfilled")
    unfulfilled.map do |item_order|
      item_order.price * item_order.quantity
    end.sum
  end

end
