class PhotosController < InheritedResources::Base
  actions :create
  respond_to :json

  def create
    @photo = Photo.create(photo_params)
  end

  protected
  def photo_params
    params.require(:photo).permit(:provider_name, :provider_uid, :username, :remote_avatar_url)
  end
end
