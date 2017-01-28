class Employee < ApplicationRecord
  acts_as_paranoid

  enum role: [:admin, :support]

  # Devise options for better security
  # :confirmable, :recoverable - disabled, only manual creation/update via console/db allowed
  # :rememberable - disabled, we dont want session to last forever and wait for a hijack
  # :lockable - consider using it for even better security
  devise :database_authenticatable, :trackable, :timeoutable

  validates_presence_of :role
  validates_presence_of :email
  validates_presence_of :password

  def timeout_in
    if Rails.env.development?
      1.week
    else
      10.minutes
    end
  end
end
