require 'faker'

FactoryGirl.define do
  factory :reply do
    sequence :id do |n| 
      n 
    end
    content { Faker::Lorem.paragraph(3) }
    feedback
    user
  end
end