module Api
  module V1
    class PagesController < Api::V1::ApiController
      before_action :authenticate_user
      before_action :set_page, only: [:show, :update, :destroy]

      def index
        @pages = policy_scope(Page)
        authorize(@pages)
        render json: @pages
      end

      def show
        render json: @page
      end

      def create
        @page = Page.new
        @page.update(page_params)
        authorize(@page)
        if @page.save
          render json: @page, status: :created
        else
          render json: @page.errors, status: :unprocessable_entity
        end
      end

      def update
        if @page.update(page_params)
          render json: @page
        else
          render json: @page.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @page.destroy
        render json: @page
      end

      private

      def page_params
        params.permit(policy(@page).permitted_attributes)
      end

      def set_page
        @page = Page.find_by_id(params[:id])
        if @page.nil?
          head :not_found
        else
          authorize(@page)
        end
      end
    end
  end
end
