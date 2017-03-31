FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password Faker::Internet.password
    password_confirmation Faker::Internet.password

    # trait :confirmed do
    #   confirmed_at { Faker::Date.backward(3) }
    # end

    factory :employee do
      #confirmed

      factory :administrator do
        # after :create do |user|
        #   user.user_roles << create(:user_role, :administrator)
        # end
      end

      factory :support do
        after :create do |user|
          user.user_roles << create(:user_role, :support)
        end
      end
    end
  end
end
