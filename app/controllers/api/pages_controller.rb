class Api::PagesController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :set_page, only: [:show, :update, :destroy]
  before_action :destroy_session

  # GET /api/pages
  def index
    @pages = Page.all
    render json: @pages, status: :ok
  end

  # GET /api/pages/:slug
  def show
    render json: @page, status: :ok
  end

  # POST /api/pages
  def create
    @page = Page.create!(permitted_attributes(@page))
    render json: @page, status: :created
  end

  # PUT /api/pages/:id
  def update
    @page.update(permitted_attributes(@page))
    head :no_content
  end

  # DELETE /api/pages/:id
  def destroy
    @page.destroy
    head :no_content
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  private

  def set_page
    @page = Page.find_by_id(params[:id])
    authorize(@page)
  end
end
