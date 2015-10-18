require "rails_helper"

RSpec.describe Product, type: :model do
  it "is valid" do
    product = Product.new(title: "Product", price: 10, description: "product text", image_url: "img1.png", stock: 10)
    expect(product.valid?).to eq true
  end
end
