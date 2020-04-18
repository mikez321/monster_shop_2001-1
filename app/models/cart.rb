class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    if item.discount_price
      item.discount_price * @contents[item.id.to_s]
    else
      item.price * @contents[item.id.to_s]
    end
  end

  def total
    @contents.sum do |item_id,quantity|
      item = Item.find(item_id)
      subtotal(item)
    end
  end

  def add_quantity(item_id)
    add_item(item_id)
  end

  def limit_reached?(item_id)
    @contents[item_id] == Item.find(item_id).inventory
  end

  def subtract_quantity(item_id)
    @contents[item_id] = 0 if !@contents[item_id]
    @contents[item_id] -= 1
  end

  def quantity_zero?(item_id)
    @contents[item_id] == 0
  end

  def has_discounts?
    discount_items = @contents.map do |id, quantity|
      item = Item.find(id)
      item.has_discount(quantity)
    end.flatten
    !discount_items.all?(false)
  end

end
