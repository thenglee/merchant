require "rails_helper"

RSpec.describe Address, type: :model do
  before do
    @user = User.create(provider: "twitter", uid: "0123456789", name: "name")
  end

  it "is valid" do
    address = Address.new(line1: "line1", line2: "line2", city: "city", state: "WA", zip: "12345", user_id: @user.id)
    expect(address.valid?).to eq true
  end
end