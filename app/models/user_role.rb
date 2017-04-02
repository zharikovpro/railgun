class UserRole < ApplicationRecord
  has_paper_trail

  TITLES = [:administrator, :developer, :support, :moderator]
  enum role: Hash[TITLES.zip(TITLES.map(&:to_s))]

  belongs_to :user

  validates_presence_of :user, :role
end
