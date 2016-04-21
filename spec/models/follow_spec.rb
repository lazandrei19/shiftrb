require 'rails_helper'

RSpec.describe Follow, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:follow)).to be_valid
  end
  it "should not be valid without a user" do
    follow = FactoryGirl.build(:follow, user: nil)
    follow.valid?
    expect(follow.errors[:user]).to include("can't be blank")
  end
  it "should not be valid without a target user" do
    follow = FactoryGirl.build(:follow, target_user: nil)
    follow.valid?
    expect(follow.errors[:target_user]).to include("can't be blank")
  end
  it "should not be valid with a duplicate user and target_user combo" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    follow1 = FactoryGirl.create(:follow, user: user1, target_user: user2)
    follow2 = FactoryGirl.build(:follow, user: user1, target_user: user2)
    follow2.valid?
    expect(follow2.errors[:user]).to include("has already been taken")
  end
end
