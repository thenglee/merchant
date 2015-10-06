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

  def get_from_product_stock(product_id, quantity_to_add)
    product = Product.find_by(id: product_id)
    if (product.stock >= quantity_to_add)
      product.stock -= quantity_to_add
      self.quantity += quantity_to_add

      if self.valid? && product.valid?
        self.save
        product.save
        return self
      end
    end
  end

  def return_order_item_to_product
    product = self.product
    if product.update_attributes(stock: product.stock + self.quantity)
      self.destroy!
      return true
    end
  end
end
