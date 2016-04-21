require 'faker'

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence :id do |n| 
      n 
    end
    email { Faker::Internet.email }
    password { Faker::Internet.password 8 }
    name { Faker::Name.first_name + " " + Faker::Name.last_name }
    avatar { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    after(:build) do |user|
        user.workplaces = FactoryGirl.create_list(:workplace, 2, user: user)
    end
  end
end