require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class DeviseNoPass < Authenticatable
      def authenticate!
        return super unless params[:user_sign_in]
        user = User.find_by_email(params[:user_sign_in])
        user ? success!(user) : raise
      end
    end
  end
end

Warden::Strategies.add(:devise_no_pass, Devise::Strategies::DeviseNoPass)
