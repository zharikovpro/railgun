class User < ApplicationRecord
  # :lockable - consider using it when users has financial transactions
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :timeoutable

  validates_presence_of :email
  validates_presence_of :password

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
end
