module Api
  module V1
    class ApiController < ApplicationController
      include Knock::Authenticable
      undef_method :current_user
      protect_from_forgery with: :null_session

      before_action :destroy_session
      before_action :authenticate_user
      before_action :authorize_resource_by_id, only: [:show, :update, :destroy]

      def destroy_session
        request.session_options[:skip] = true
      end

      def index
        resources = policy_scope(resource_model)
        authorize(resources)
        render json: resources
      end

      def show
        render json: resource_by_id
      end

      def create
        save_attributes_with_status(resource_model.new, :created)
      end

      def update
        save_attributes_with_status(resource_by_id, :ok)
      end

      def destroy
        resource_by_id.destroy
        render json: nil, status: :no_content
      end

      private

      def resource_model
        request.path.split('/')[3].classify.constantize
      end

      def resource_by_id
        @resource ||= resource_model.find_by_id(params[:id])
      end

      def authorize_resource_by_id
        resource = resource_by_id

        if resource.nil?
          skip_authorization
          head :not_found
        else
          authorize(resource)
        end
      end

      def resource_params(resource)
        params.permit(policy(resource).permitted_attributes)
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
