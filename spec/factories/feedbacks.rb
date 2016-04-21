require 'faker'

FactoryGirl.define do
  factory :feedback do
    sequence :id do |n| 
      n 
    end
    content { Faker::Lorem.paragraph(3) }
    project
    user
  end
end