class User < ApplicationRecord
  enum role: {
    admin: 'admin',
    support: 'support',
    consumer: 'consumer'
  }

  # :lockable - consider using it when users has financial transactions
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable, :timeoutable

  validates_presence_of :email
  validates_presence_of :password

  def timeout_in
    7.days
  end
end
