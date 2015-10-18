require "rails_helper"

RSpec.describe Order, type: :model do
  it "is valid" do
    order = Order.new(status: "unsubmitted")
    expect(order.valid?).to eq true
  end
end