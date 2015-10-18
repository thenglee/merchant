require "rails_helper"

RSpec.describe Product, type: :model do
  it "is valid" do
    product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
    expect(product.valid?).to eq true
  end

  describe "validations" do
    it "should have a title" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
      product.title = nil
      expect(product.valid?).to eq false
    end

    it "should have a price" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
      product.price = nil
      expect(product.valid?).to eq false
    end

    it "should have a description" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
      product.description = nil
      expect(product.valid?).to eq false
    end

    it "should have a image_url" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
      product.image_url = nil
      expect(product.valid?).to eq false
    end

    it "should have a stock" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
      product.stock = nil
      expect(product.valid?).to eq false
    end
  end
end
