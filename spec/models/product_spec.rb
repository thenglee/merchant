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

    it "should have a numerical value for price" do
      product = Product.new(title: "Product", price: "ten", description: "product text", image_url: "img1.png", stock: 10)
      expect(product.valid?).to eq false
    end

    it "should have a positive value for price" do
      product = Product.new(title: "Product", price: -10, description: "product text", image_url: "img1.png", stock: 10)
      expect(product.valid?).to eq false
    end

    it "should have a numerical value for stock" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: "ten")
      expect(product.valid?).to eq false
    end

    it "should have an integer value for stock" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10.50)
      expect(product.valid?).to eq false
    end

    it "should have a positive integer value for stock" do
      product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: -10)
      expect(product.valid?).to eq false
    end
  end
end
