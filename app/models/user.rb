class User < ApplicationRecord
  # :lockable - consider using it for ban feature
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :timeoutable

  validates_presence_of :email
  validates_presence_of :password

  def timeout_in
    7.days
  end
end
