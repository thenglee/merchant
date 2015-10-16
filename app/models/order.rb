class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  belongs_to :user
  belongs_to :address

  # validates_presence_of :address_id

  def total
    sum = 0
    self.order_items.each do |order_item| 
      sum = sum + order_item.subtotal
    end
    sum
  end

  def clear_order
    # Add order items quantities back to products stock
    self.order_items.collect do |order_item|
      product = order_item.product
      product.stock += order_item.quantity
      product.save
      order_item.destroy
    end

  end

end
