class Api::PagesController < Api::ApiController
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
    @page = Page.create!(permitted_attributes(@page))
    authorize(@page)
    render json: @page, status: :created
  end

  def update
    @page.update(permitted_attributes(@page))
    head :no_content
  end

  def destroy
    @page.destroy
    head :no_content
  end

  private

  def set_page
    @page = Page.find_by_id(params[:id])
    authorize(@page)
  end
end
