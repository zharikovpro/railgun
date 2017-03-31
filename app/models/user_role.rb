class UserRole < ApplicationRecord
  TITLES = [:administrator, :developer, :support, :moderator]
  enum role: Hash[TITLES.zip(TITLES)]

  belongs_to :grantor, inverse_of: :user
  belongs_to :user, inverse_of: :user_roles
end
