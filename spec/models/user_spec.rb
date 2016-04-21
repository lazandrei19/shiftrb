require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it "is invalid without email" do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid without password" do
    user = FactoryGirl.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  it "is invalid without name" do
    user = FactoryGirl.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  it "is invalid if the password is shorter than 8 characters" do
    user = FactoryGirl.build(:user, password: "a")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end
  it "is invalid without avatar" do
    user = FactoryGirl.build(:user, avatar: nil)
    user.valid?
    expect(user.errors[:avatar]).to include("can't be blank")
  end
  it "is invalid with duplicate email" do
    user1 = FactoryGirl.create(:user, email: "a@b.c")
    user2 = FactoryGirl.build(:user, email: "a@b.c")
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end
  it "should return a hashed id" do
    user = FactoryGirl.create(:user)
    expect(user.to_param).to eq(Digest::SHA1.hexdigest("--shift_lazandrei19--#{user.id}--")[0..15])
  end
end