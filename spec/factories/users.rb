FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password Faker::Internet.password
    password_confirmation Faker::Internet.password

    factory :employee do
      UserRole::TITLES.each do |title|
        factory title do
          after :create do |user|
            user.user_roles << create(:user_role, title)
          end
        end
      end
    end
  end
end
