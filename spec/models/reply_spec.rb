require 'rails_helper'

RSpec.describe Reply, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:reply)).to be_valid
  end
  it "is invalid without content" do
    reply = FactoryGirl.build(:reply, content: nil)
    reply.valid?
    expect(reply.errors[:content]).to include("can't be blank")
  end
  it "is invalid without feedback" do
    reply = FactoryGirl.build(:reply, feedback: nil)
    reply.valid?
    expect(reply.errors[:feedback]).to include("can't be blank")
  end
  it "is invalid without user" do
    reply = FactoryGirl.build(:reply, user: nil)
    reply.valid?
    expect(reply.errors[:user]).to include("can't be blank")
  end
end
