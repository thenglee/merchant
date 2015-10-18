require "rails_helper"

RSpec.describe Product, type: :model do
  it "is valid" do
    product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
    expect(product.valid?).to eq true
  end

  describe "validations" do
    before do
      @product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
    end

    [:title, :price, :description, :image_url, :stock].each do |attr|
      it "should have a #{attr}" do
        @product.send("#{attr}=", nil)
        expect(@product.valid?).to eq false
      end
    end

    it "should have a title" do
      @product.title = nil
      expect(@product.valid?).to eq false
    end

    it "should have a price" do
      @product.price = nil
      expect(@product.valid?).to eq false
    end

    it "should have a description" do
      @product.description = nil
      expect(@product.valid?).to eq false
    end

    it "should have a image_url" do
      @product.image_url = nil
      expect(@product.valid?).to eq false
    end

    it "should have a stock" do
      @product.stock = nil
      expect(@product.valid?).to eq false
    end

    [:price, :stock].each do |attr|
      it "should have a numerical value for #{attr}" do
        @product.send("#{attr}=", "ten")
        expect(@product.valid?).to eq false
      end

      it "should have a positive value for #{attr}" do
        @product.send("#{attr}=", -10)
        expect(@product.valid?).to eq false
      end
    end

    it "should have a numerical value for price" do
      @product.price = "ten"
      expect(@product.valid?).to eq false
    end

    it "should have a positive value for price" do
      @product.price = -10
      expect(@product.valid?).to eq false
    end

    it "should have a numerical value for stock" do
      @product.stock = "ten"
      expect(@product.valid?).to eq false
    end

    it "should have an integer value for stock" do
      @product.stock = 10.50
      expect(@product.valid?).to eq false
    end

    it "should have a positive integer value for stock" do
      @product.stock = -10
      expect(@product.valid?).to eq false
    end
  end


  describe "methods" do
    before do
      @product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
    end

    describe "#in_stock?" do
      it "should return true when a product has stock" do
        expect(@product.in_stock?).to eq true
      end

      it "should return false when a product has no stock" do
        @product.stock = 0
        expect(@product.in_stock?).to eq false
      end
    end
  end
end
