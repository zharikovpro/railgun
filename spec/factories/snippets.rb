FactoryGirl.define do
  factory :snippet do
    slug { Faker::Internet.slug }
    text Faker::Hacker.say_something_smart
  end
end
