require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class DeviseNoPass < Authenticatable
      def authenticate!
        if params[:user][:email]
          user = User.find_by_email(params[:user][:email])
          user ? success!(user) : fail
        end
      end
    end
  end
end

Warden::Strategies.add(:devise_no_pass, Devise::Strategies::DeviseNoPass)
