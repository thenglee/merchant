require "rails_helper"

RSpec.describe Order, type: :model do
  it "is valid" do
    order = Order.new(status: "unsubmitted")
    expect(order.valid?).to eq true
  end

  it "should have status" do
    order = Order.new
    expect(order.valid?).to eq false
  end

  describe "model associations" do
    before do
      @order = Order.create(status: "unsubmitted")
    end

    it "should have order items" do
      expect(@order.respond_to?(:order_items)).to eq true
    end

    it "should return its order items" do
      product = Product.create(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
      order_item = OrderItem.create(order_id: @order.id, product_id: product.id, quantity: 10)
      expect(@order.order_items).to eq [order_item]
    end

    it "should have user" do
      expect(@order.respond_to?(:user)).to eq true
    end

    it "should return its user" do
      user = User.create(provider: "twitter", uid: "0123456789", name: "name")
      @order.user_id = user.id
      expect(@order.user).to eq user
    end

    it "should have address" do
      expect(@order.respond_to?(:address)).to eq true
    end

    it "should return its address" do
      user = User.create(provider: "twitter", uid: "0123456789", name: "name")
      address = Address.create(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345", user_id: user.id)
      @order.address_id = address.id
      expect(@order.address).to eq address
    end
  end
end