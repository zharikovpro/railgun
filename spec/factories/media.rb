FactoryBot.define do
  factory :media do
    slug { Faker::Internet.unique.slug }
    file { File.new("#{Rails.root}/spec/fixtures/files/images/demo.jpg") }
  end
end
