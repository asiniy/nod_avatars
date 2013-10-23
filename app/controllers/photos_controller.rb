class PhotosController < InheritedResources::Base
  include GetOmniauth
  actions :new, :create

  def new
    @photo = Photo.create(photo_params)
    redirect_to root_path
  end
end
