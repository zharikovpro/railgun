module Api
  module V1
    class ApiController < ApplicationController
      include Knock::Authenticable
      undef_method :current_user
      protect_from_forgery with: :null_session

      before_action :destroy_session
      before_action :authenticate_user

      def destroy_session
        request.session_options[:skip] = true
      end

      def index
        authorize(resource_model)
        resources = policy_scope(resource_model)
        render json: resources
      end

      def show
        resource = authorize_resource_by_id
        render json: resource if resource
      end

      def create
        save_attributes_with_status(resource_model.new, :created)
      end

      def update
        resource = authorize_resource_by_id
        if resource.present?
          save_attributes_with_status(resource, :ok)
        end
      end

      def destroy
        resource = authorize_resource_by_id
        if resource.present?
          resource.destroy
          render json: nil, status: :no_content
        end
      end

      private

      def resource_model
        request.path.split('/')[3].classify.constantize
      end

      def resource_params(resource)
        params.permit(policy(resource).permitted_attributes)
      end

      def authorize_resource_by_id
        resource = resource_model.find_by_id(params[:id])

        if resource.nil?
          skip_authorization
          head :not_found
        else
          authorize(resource)
        end

        resource
      end

      def save_attributes_with_status(resource, status)
        resource.assign_attributes(resource_params(resource))
        authorize(resource)

        if resource.save
          render json: resource, status: status
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
