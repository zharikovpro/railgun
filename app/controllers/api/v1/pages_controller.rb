module Api
  module V1
    class PagesController < Api::V1::ApiController
      before_action :set_resource, only: [:show, :update, :destroy]

      def index
        @resources = policy_scope(request.path.split('/')[3].classify.constantize)
        authorize(@resources)
        render json: @resources
      end

      def show
        render json: @resource
      end

      def create
        @resource = request.path.split('/')[3].classify.constantize.new
        @resource.assign_attributes(resource_params)
        authorize(@resource)
        if @resource.save
          render json: @resource, status: :created
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end

      def update
        if @resource.update(resource_params)
          render json: @resource
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @resource.destroy
        render json: @resource
      end

      private

      def resource_params
        params.permit(policy(@resource).permitted_attributes)
      end

      def set_resource
        resource = request.path.split('/')[3].classify.constantize
        @resource = resource.find_by_id(params[:id])
        if @resource.nil?
          head :not_found
        else
          authorize(@resource)
        end
      end
    end
  end
end
