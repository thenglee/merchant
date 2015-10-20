require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid" do
    user = User.new(provider: "twitter", uid: "0123456789", name: "name")
    expect(user.valid?).to eq true
  end

  describe "model associations" do
    before do
      @user = User.create(provider: "twitter", uid: "0123456789", name: "name")
    end

    it "should have orders" do
      expect(@user.respond_to?(:orders)).to eq true
    end

    it "should return its orders" do
      order = Order.create(status: "unsubmitted", user_id: @user.id)
      expect(@user.orders).to eq [order]
    end

    it "should have addresses" do
      expect(@user.respond_to?(:addresses)).to eq true
    end

    it "should return its addresses" do
      address = Address.create(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345", user_id: @user.id)
      expect(@user.addresses).to eq [address]
    end
  end
end