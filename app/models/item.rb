class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders
  has_many :discount_items
  has_many :discounts, through: :discount_items

  validates_presence_of :name,
                        :description,
                        :price,
                        # :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, :inventory, greater_than_or_equal_to: 0

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.most_popular_5
    joins(:item_orders).group(:id)
                       .order('SUM (item_orders.quantity) DESC')
                       .limit(5)
  end

  def self.least_popular_5
    joins(:item_orders).group(:id)
                       .order('SUM (item_orders.quantity) ASC')
                       .limit(5)
  end

  def qty_purchased
    item_orders.sum(:quantity)
  end

  def order_qty_purchased(order)
  item_orders.where(order_id: order)
               .sum(:quantity)
  end

  def subtotal(order)
    price * order_qty_purchased(order)
  end


  def order_status(order)
    item_orders.where(order_id: order).first.status
  end

  def status
    return "active" if active?
      "inactive"
  end

  def get_discounts(quantity)
    discounts.clear
    discount = Discount.where("quantity <= #{quantity}")
                       .where(merchant_id: merchant_id)
    discounts << discount
  end

  def discount_price
    new_price = discounts.map do |discount|
      price - (price * (discount.amount.to_f/100))
    end.min
  end

  def final_price
    return discount_price if discount_price
    price
  end

end
