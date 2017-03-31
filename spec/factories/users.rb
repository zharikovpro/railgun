FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    password_confirmation Faker::Internet.password

    trait :confirmed do
      confirmed_at { Faker::Date.backward(3) }
    end

    factory :administrator do
      confirmed
    end
  end
end
