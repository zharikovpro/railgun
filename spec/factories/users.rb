FactoryGirl.define do
  factory :consumer do
    role :consumer
    email Faker::Internet.email
    password Faker::Internet.password
    password_confirmation Faker::Internet.password
  end
end
