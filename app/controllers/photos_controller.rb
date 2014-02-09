class PhotosController < ApplicationController
  def new
    @photo = PhotoPublisher.new(request.env['omniauth.auth'])

    if @photo.save
      redirect_to root_path(photo_id: @photo.id)
    else
      redirect_to root_path, error: @photo.error
    end
  end
end
