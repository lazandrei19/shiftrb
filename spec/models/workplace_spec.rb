require 'rails_helper'

RSpec.describe Workplace, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:workplace)).to be_valid
  end
  it "is invalid without company" do
    workplace = FactoryGirl.build(:workplace, company: nil)
    workplace.valid?
    expect(workplace.errors[:company]).to include("can't be blank")
  end
  it "is invalid without position" do
    workplace = FactoryGirl.build(:workplace, position: nil)
    workplace.valid?
    expect(workplace.errors[:position]).to include("can't be blank")
  end
  it "is invalid without emoji" do
    workplace = FactoryGirl.build(:workplace, emoji: nil)
    workplace.valid?
    expect(workplace.errors[:emoji]).to include("can't be blank")
  end
  it "is invalid with text in the emoji field" do
    workplace = FactoryGirl.build(:workplace, emoji: "u")
    workplace.valid?
    expect(workplace.errors[:emoji]).to include("is invalid")
  end
  it "is invalid with more than one emoji" do
    workplace = FactoryGirl.build(:workplace, emoji: "😂😂")
    workplace.valid?
    expect(workplace.errors[:emoji]).to include("is the wrong length (should be 1 character)")
  end
  it "is invalid without user" do
    workplace = FactoryGirl.build(:workplace, user: nil)
    workplace.valid?
    expect(workplace.errors[:user]).to include("can't be blank")
  end
end
