class MediasController < ApplicationController
  def show
    media = Media.find_by_slug(params[:id])
    authorize media
    redirect_to(media.file.url, status: 303)
  end
end
