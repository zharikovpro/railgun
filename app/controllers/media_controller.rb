class MediaController < ApplicationController
  def show
    @media = Media.find_by_slug(params[:id])
    authorize @media
  end
end
