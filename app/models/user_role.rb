class UserRole < ApplicationRecord
  has_paper_trail

  TITLES = [:administrator, :developer, :support, :moderator]
  enum role: Hash[TITLES.zip(TITLES.map(&:to_s))]

  belongs_to :grantor, class_name: 'User'
  belongs_to :user

  validates_presence_of :user, :role

  def readonly?
    true
  end
end
