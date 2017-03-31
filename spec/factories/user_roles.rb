FactoryGirl.define do
  factory :user_role do
    association :user
    association :grantor, factory: :user
    role :administrator

    UserRole::TITLES.each do |title|
      trait title do
        role title
      end
    end
  end
end
