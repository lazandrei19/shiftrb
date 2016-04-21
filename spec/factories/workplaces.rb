require 'faker'

FactoryGirl.define do
  factory :workplace do
    sequence :id do |n| 
      n 
    end
    company { Faker::Company.name }
    position { Faker::Company.profession }
    emoji "😂"
    user
  end
end