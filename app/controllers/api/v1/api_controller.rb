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

      def authenticate_user
        unless current_user
          render json: { message: 'Not Authorized' }, status: :unauthorized
        end
      end
    end
  end
end

