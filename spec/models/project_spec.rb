require 'rails_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:project)).to be_valid
  end
  it "is invalid without name" do
    project = FactoryGirl.build(:project, name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end
  it "is invalid without logo" do
    project = FactoryGirl.build(:project, logo: nil)
    project.valid?
    expect(project.errors[:logo]).to include("can't be blank")
  end
  it "is invalid without headline" do
    project = FactoryGirl.build(:project, headline: nil)
    project.valid?
    expect(project.errors[:headline]).to include("can't be blank")
  end
  it "is invalid without description" do
    project = FactoryGirl.build(:project, description: nil)
    project.valid?
    expect(project.errors[:description]).to include("can't be blank")
  end
  it "is invalid without user" do
    project = FactoryGirl.build(:project, user: nil)
    project.valid?
    expect(project.errors[:user]).to include("can't be blank")
  end
  it "should return a hashed id" do
    project = FactoryGirl.create(:project)
    expect(project.to_param).to eq(Digest::SHA1.hexdigest("--shift_lazandrei19--#{project.id}--")[0..15])
  end
end
