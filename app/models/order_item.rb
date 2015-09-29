class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :order_id, :product_id, presence: true
  validates :quantity, numericality: { 
  	                     only_integer: true, 
  	                     greater_than: 0
  	                   }

  def subtotal # this is an instance method, it will be called on one 'order_item' instance/row
    self.product.price * self.quantity
  end

  # def self.find_outdated # this is a class method, it will be called on the 'order_items' table
  #   self.where(status: "outdated")
  # end
end
