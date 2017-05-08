module Api
  module V1
    class SnippetsController < Api::V1::ApiController
      before_action :authenticate_user
      before_action :set_snippet, only: [:show, :update, :destroy]

      def index
        @snippets = policy_scope(Snippet)
        authorize(@snippets)
        render json: @snippets
      end

      def show
        render json: @snippet
      end

      def create
        @snippet = Snippet.new
        @snippet.assign_attributes(snippet_params)
        authorize(@snippet)
        if @snippet.save
          render json: @snippet, status: :created
        else
          render json: @snippet.errors, status: :unprocessable_entity
        end
      end

      def update
        if @snippet.update(snippet_params)
          render json: @snippet
        else
          render json: @snippet.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @snippet.destroy
        render json: @snippet
      end

      private

      def snippet_params
        params.permit(policy(@snippet).permitted_attributes)
      end

      def set_snippet
        @snippet = Snippet.find_by_id(params[:id])
        if @snippet.nil?
          head :not_found
        else
          authorize(@snippet)
        end
      end
    end
  end
end
