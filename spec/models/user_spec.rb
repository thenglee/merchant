require "rails_helper"

RSpec.describe User, type: :model do
  it "is valid" do
    user = User.new(provider: "twitter", uid: "0123456789", name: "name")
    expect(user.valid?).to eq true
  end
end