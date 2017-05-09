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
        resources = policy_scope(resource_model)
        authorize(resources)
        render json: resources
      end

      def show
        resource = authorize_resource_by_id
        render json: authorize_resource_by_id if resource
      end

      def create
        resource = resource_model.new
        resource.assign_attributes(resource_params(resource))
        authorize(resource)

        if resource.save
          render json: resource, status: :created
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

      def update
        resource = authorize_resource_by_id
        resource.assign_attributes(resource_params(resource))
        authorize(resource)

        if resource.save
          render json: resource, status: :ok
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize_resource_by_id.destroy
        render json: nil, status: :no_content
      end

      private

      def resource_model
        request.path.split('/')[3].classify.constantize
      end

      def resource_params(resource = nil)
        params.permit(policy(resource || resource_model.new).permitted_attributes)
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
    end
  end
end
