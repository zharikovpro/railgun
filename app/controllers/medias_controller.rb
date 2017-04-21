class MediasController < ApplicationController
  def show
    @media = Media.find_by_slug(params[:id])
    authorize @media
    #TODO redirect 303
  end
end
