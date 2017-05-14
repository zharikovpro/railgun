FactoryGirl.define do
  factory :page do
    slug { Faker::Internet.unique.slug }
    markdown Faker::Hacker.say_something_smart
  end
end
