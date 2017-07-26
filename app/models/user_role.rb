class UserRole < ApplicationRecord
  has_paper_trail

  TITLES = [:owner, :administrator, :developer, :editor, :support, :moderator].freeze
  enum role: Hash[TITLES.zip(TITLES.map(&:to_s))]

  belongs_to :user

  validates_presence_of :user, :role
end
