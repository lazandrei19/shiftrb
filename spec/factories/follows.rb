FactoryGirl.define do
  factory :follow do
    sequence :id do |n| 
      n 
    end
    user
    association :target_user, factory: :user
  end
end