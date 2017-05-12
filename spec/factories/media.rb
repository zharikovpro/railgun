FactoryGirl.define do
  factory :media do
    slug { Faker::Internet.unique.slug }
    file { File.new("#{Rails.root}/spec/media/images/demo.jpg") }
  end
end
