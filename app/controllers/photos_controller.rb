class PhotosController < ApplicationController
  def new
    @photo = PhotoPublisher.new(request.env['omniauth.auth'])

    if @photo.save
      redirect_to root_path(photo_id: @photo.id), flash: { success: t('photo_publisher.saved') }
    else
      redirect_to root_path, flash: { danger: t('photo_publisher.unsaved') }
    end
  end
end
