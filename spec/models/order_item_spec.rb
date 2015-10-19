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
    before do
      @order_item = OrderItem.new(order_id: @order.id, product_id: @product.id, quantity: 10)
    end

    it "should have an order" do
      @order_item.order_id = nil
      expect(@order_item.valid?).to eq false
    end

    it "should have a product" do
      @order_item.product_id = nil
      expect(@order_item.valid?).to eq false
    end

    it "should have quantity" do
      @order_item.quantity = nil
      expect(@order_item.valid?).to eq false
    end

    it "should have a numerical value for quantity" do
      @order_item.quantity = "ten"
      expect(@order_item.valid?).to eq false
    end

    it "should have an integer value for quantity" do
      @order_item.quantity = 10.50
      expect(@order_item.valid?).to eq false
    end

    it "should have a positive integer value for quantity" do
      @order_item.quantity = -10
      expect(@order_item.valid?).to eq false
    end
  end

  describe "model associations" do
    before do
      @order_item = OrderItem.new(order_id: @order.id, product_id: @product.id, quantity: 10)
    end

    [:order, :product].each do |attr|
      it "should have #{attr}" do
        expect(@order_item.respond_to?(attr)).to eq true
      end
    end

    it "should have order" do
      expect(@order_item.respond_to?(:order)).to eq true
    end

    it "should return its order" do
      expect(@order_item.order).to eq @order
    end

    it "should have product" do
      expect(@order_item.respond_to?(:product)).to eq true
    end

    it "should return its product" do
      expect(@order_item.product).to eq @product
    end
  end
end
