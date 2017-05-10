module Api
  module V1
    class ApiController < ApplicationController
      include Knock::Authenticable
      undef_method :current_user
      protect_from_forgery with: :null_session

      before_action :destroy_session
      before_action :authenticate_user
      before_action :set_resource, only: [:show]

      def destroy_session
        request.session_options[:skip] = true
      end

      def index
        resources = policy_scope(model)
        authorize(resources)
        render json: resources
      end

      def show
        render json: set_resource
      end

      def create
        assign_attributes_and_save(model.new, :created)
      end

      def update
        assign_attributes_and_save(set_resource, :ok)
      end

      def destroy
        resource = set_resource
        resource.destroy
        render json: resource
      end

      private

      def assign_attributes_and_save(resource, status)
        resource.assign_attributes(resource_params)
        authorize(resource)
        if resource.save
          render json: resource, status: status
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end

      def resource_params
        params.permit(policy(model.new || set_resource).permitted_attributes)
      end

      def model
        request.path.split('/')[3].classify.constantize
      end

      def set_resource
        resource = model.find_by_id(params[:id])
        if resource.nil?
          head :not_found
        else
          authorize(resource)
        end
        resource
      end
    end
  end
end
