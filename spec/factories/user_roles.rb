FactoryGirl.define do
  factory :user_role do
    association :user
    association :grantor, factory: :user

    factory :support do
      role :support
    end
  end
end
