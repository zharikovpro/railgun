FactoryBot.define do
  factory :user_role do
    association :user
    role { :administrator }

    UserRole::TITLES.each do |title|
      trait title do
        role { title }
      end
    end
  end
end
