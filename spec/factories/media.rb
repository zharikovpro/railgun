FactoryGirl.define do
  factory :media do
    slug Faker::Internet.slug
    file { File.new("#{Rails.root}/spec/media/images/demo.png") }
  end
end
