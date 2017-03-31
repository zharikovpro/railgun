class UserRole < ApplicationRecord
  enum role: {
    admin: 'admin',
    support: 'support',
    consumer: 'consumer'
  }
end
