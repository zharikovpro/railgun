require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class DeviseNoPass < Authenticatable
      def authenticate!
        return super unless params[:customer_sign_in]
        customer = Customer.find_by_phone(params[:customer_sign_in])
        customer ? success!(customer) : raise
      end
    end
  end
end

Warden::Strategies.add(:devise_no_pass, Devise::Strategies::DeviseNoPass)
