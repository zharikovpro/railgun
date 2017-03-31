class UserRole < ApplicationRecord
  TITLES = [:administrator, :developer, :support, :moderator]
  enum role: Hash[TITLES.zip(TITLES.map(&:to_s))]

  belongs_to :grantor, class_name: 'User'
  belongs_to :user

  validates_presence_of :grantor, :user, :role
end
