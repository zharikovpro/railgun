class PagesController < ApplicationController
  before_action :set_page, only: [:show, :update, :destroy]

  # GET /pages
  def index
    @pages = page.all
    json_response(@pages)
  end

  # GET /pages/:slug
  def show
    json_response(@page)
    authorize(@page)
  end

  # POST /pages
  def create
    @page = page.create!(page_params)
    json_response(@page, :created)
  end

  # PUT /pages/:slug
  def update
    @page.update(page_params)
    head :no_content
  end

  # DELETE /pages/:slug
  def destroy
    @page.destroy
    head :no_content
  end

  private

  def page_params
    params.permit(:slug, :markdown)
  end

  def set_page
    @page = Page.find_by_slug(params[:id])
  end
end
