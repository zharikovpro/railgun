class AdminUser < ApplicationRecord
  # Devise options for better security
  # :confirmable, :recoverable - disabled, only manual creation/update via console/db allowed
  # :rememberable - disabled, we dont want session to last forever and wait for a hijack
  # :lockable - consider using it for even better security
  devise :database_authenticatable, :trackable, :timeoutable

  def timeout_in
    10.minutes
  end
end
