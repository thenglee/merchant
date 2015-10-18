require "rails_helper"

RSpec.describe OrderItem, type: :model do
  before do
    @product = Product.create(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
    @order = Order.create(status: "unsubmitted")
  end

  it "is valid" do
    order_item = OrderItem.new(order_id: @order.id, product_id: @product.id, quantity: 10)
    expect(order_item.valid?).to eq true
  end

  describe "validations" do
    it "should have an order" do
      order_item = OrderItem.new(product_id: @product.id, quantity: 10)
      expect(order_item.valid?).to eq false
    end

    it "should have a product" do
      order_item = OrderItem.new(order_id: @order.id, quantity: 10)
      expect(order_item.valid?).to eq false
    end
  end
end
