class User < ApplicationRecord
  # :lockable - consider using it when users has financial transactions
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable

  validates_presence_of :email
  validates_presence_of :password

  has_many :user_roles, inverse_of: :user

  # TODO: def timeout_in
  #   if employee?
  #     30.minutes
  #   else
  #     7.days
  #   end
  # end
  #
  # TODO: def employee?
  #   role != 'consumer'
  # end
  #
  # TODO: def confirmation_required?
  #   employee?
  # end

  # def customer?
  #   true
  # end

  # def employee?
  #   false
  # end
  #
  # def administrator?
  #   true
  # end
  #
  def developer?
    false
  end
end
