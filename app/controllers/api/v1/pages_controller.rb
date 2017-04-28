module Api
  module V1
    class PagesController < Api::V1::ApiController
      before_action :set_page, only: [:show, :update, :destroy]

      def index
        @pages = policy_scope(Page)
        authorize(@pages)
        render json: @pages, status: :ok
      end

      def show
        render json: @page, status: :ok
      end

      def create
        begin
          @page = Page.create!(page_params)
        rescue ActiveRecord::RecordInvalid => e
          @exeption = {json: { message: e.message }, status: :unprocessable_entity}
        end
        begin
          authorize(@page)
        rescue Pundit::NotDefinedError
        end
        if @page.nil?
          render @exeption
        else
          render json: @page, status: :created
        end
      end

      def update
        @page.update(page_params)
        head :no_content
      end

      def destroy
        @page.destroy
        head :no_content
      end

      private

      def page_params
        params.permit(:slug, :markdown)
      end

      def set_page
        @page = Page.find_by_id(params[:id])
        if @page.nil?
          render json: { message: "Couldn't find page" }, status: :not_found
        else
          authorize(@page)
        end
      end
    end
  end
end

