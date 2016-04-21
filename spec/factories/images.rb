include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    sequence :id do |n| 
      n 
    end
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
  end
end