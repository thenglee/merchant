class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  belongs_to :user

  def total
    sum = 0
    self.order_items.each do |order_item| 
      sum = sum + order_item.subtotal
    end
    sum
  end

end
