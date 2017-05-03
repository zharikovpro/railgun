module Api
  module V1
    class ApiController < ApplicationController
      include Knock::Authenticable
      undef_method :current_user
      protect_from_forgery with: :null_session

      before_action :destroy_session

      def destroy_session
        request.session_options[:skip] = true
      end
    end
  end
end
