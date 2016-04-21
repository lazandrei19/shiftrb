require 'rails_helper'

RSpec.describe Image, type: :model do
  it "has valid factory" do
    expect(FactoryGirl.create(:image)).to be_valid
  end
  it "is invalid without an image" do
    image = FactoryGirl.build(:image, image: nil)
    image.valid?
    expect(image.errors[:image]).to include("can't be blank")
  end
end
