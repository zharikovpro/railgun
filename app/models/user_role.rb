class UserRole < ApplicationRecord
  ROLES = [:administrator, :developer, :support, :moderator]
  enum role: Hash[ROLES.zip(ROLES)]
end
