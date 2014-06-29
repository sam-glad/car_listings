FactoryGirl.define do
  factory :car do
    color 'Black'
    year '1950'
    sequence(:mileage) { |n| "#{n}" }
    manufacturer
    description "This car number #{n}."
  end
end
