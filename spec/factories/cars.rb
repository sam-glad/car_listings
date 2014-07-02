FactoryGirl.define do
  factory :car do
    color 'Black'
    sequence(:year) { |n| "195#{n}" }
    sequence(:mileage) { |n| "#{n}" }
    manufacturer
    sequence(:description) { |n| "This is car number #{n}." }
  end
end
