FactoryBot.define do
  factory :snippet do
    slug { Faker::Internet.unique.slug }
    text { Faker::Hacker.say_something_smart }
  end
end
