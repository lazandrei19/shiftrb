require 'faker'

FactoryGirl.define do
  factory :project do
    sequence :id do |n| 
      n 
    end
    name { Faker::Company.name }
    headline { Faker::Company.catch_phrase }
    description { Faker::Lorem.paragraph(6) }
    logo { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
    user
  end
end