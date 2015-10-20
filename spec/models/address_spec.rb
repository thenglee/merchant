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
  end
end