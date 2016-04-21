require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:feedback)).to be_valid
  end
  it "is invalid without content" do
    feedback = FactoryGirl.build(:feedback, content: nil)
    feedback.valid?
    expect(feedback.errors[:content]).to include("can't be blank")
  end
  it "is invalid without project" do
    feedback = FactoryGirl.build(:feedback, project: nil)
    feedback.valid?
    expect(feedback.errors[:project]).to include("can't be blank")
  end
  it "is invalid without user" do
    feedback = FactoryGirl.build(:feedback, user: nil)
    feedback.valid?
    expect(feedback.errors[:user]).to include("can't be blank")
  end
  it "should return a hashed id" do
    feedback = FactoryGirl.create(:feedback)
    expect(feedback.to_param).to eq(Digest::SHA1.hexdigest("--shift_lazandrei19--#{feedback.id}--")[0..15])
  end
end
