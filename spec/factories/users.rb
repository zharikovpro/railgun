FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    password_confirmation Faker::Internet.password
  end
end
