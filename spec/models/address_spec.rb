require "rails_helper"

RSpec.describe Address, type: :model do
  before do
    @user = User.create(provider: "twitter", uid: "0123456789", name: "name")
  end

  it "is valid" do
    address = Address.new(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345", user_id: @user.id)
    expect(address.valid?).to eq true
  end

  describe "validations" do
    before do
      @address = Address.new(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345", user_id: @user.id)
    end

    it "should have line1" do
      @address.line1 = nil
      expect(@address.valid?).to eq false
    end

    it "should have city" do
      @address.city = nil
      expect(@address.valid?).to eq false
    end

    it "should have state" do
      @address.state = nil
      expect(@address.valid?).to eq false
    end

    it "should have zip" do
      @address.zip = nil
      expect(@address.valid?).to eq false
    end

    it "should have user" do
      @address.user_id = nil
      expect(@address.valid?).to eq false
    end

    it "should have numerical value for zip" do
      @address.zip = "one"
      expect(@address.valid?).to eq false
    end

    it "should have an integer value for zip" do
      @address.zip = 123.4
      expect(@address.valid?).to eq false
    end

    it "should have positive integer value for zip" do
      @address.zip = -1234
      expect(@address.valid?).to eq false
    end

    it "should have minimum length of 5 for zip" do
      @address.zip = 1234
      expect(@address.valid?).to eq false
    end

    it "should have maximum length of 5 for zip" do
      @address.zip = 123456
      expect(@address.valid?).to eq false
    end

    it "should have minimum length of 2 for state" do
      @address.state = "A"
      expect(@address.valid?).to eq false
    end

     it "should have maximum length of 2 for state" do
      @address.state = "MAD"
      expect(@address.valid?).to eq false
    end

    it "should not have numerical value for state" do
      @address.state = 11
      expect(@address.valid?).to eq false
    end

    it "should have uppercase value for state" do
      @address.state = "cA"
      expect(@address.valid?).to eq false
    end

    it "should match US state abbreviation for state" do
      @address.state = "AA"
      expect(@address.valid?).to eq false
    end
  end

  describe "model assocations" do
    before do
      @address = Address.create(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345", user_id: @user.id)
    end

    it "should have user" do
      expect(@address.respond_to?(:user)).to eq true
    end

    it "should return its user" do
      expect(@address.user).to eq @user
    end

    it "should have orders" do
      expect(@address.respond_to?(:orders)).to eq true
    end

    it "should return its orders" do
      order = Order.create(status: "unsubmitted", address_id: @address.id)
      expect(@address.orders).to eq [order]
    end
  end
end