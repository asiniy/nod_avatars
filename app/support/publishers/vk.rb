class Publishers::Vk
  def initialize(photo)
    @photo = photo
  end

  def published?
    @published ||= upload_photo_from_profile? && unload_photo_to_profile?
  end

  private

  def upload_photo_from_profile?
    avatar_urls = APIResponseParser.parse(GET_PHOTO_PROFILE_URL, params: {
        owner_id: @photo.provider_uid,
        album_id: '-6',
        rev: 1,
        access_token: @photo.provider_token
    })[:response][0].symbolize_keys.select{ |k,_| k.match(/src/) }

    biggest_avatar_url = avatar_urls[avatar_urls.keys.reverse.first]

    @photo.remote_avatar_url = biggest_avatar_url
    @photo_path = AvatarsUploader.new
    @photo_path.download!(biggest_avatar_url)
    @photo_path.store!
  end

  def unload_photo_to_profile?
    get_unload_server? && unloaded_photo? && set_profile_photo?
  end

  def get_unload_server?
    @get_upload_server ||= APIResponseParser.parse(GET_VK_UPLOAD_SERVER_URL, params: {
      access_token: @photo.provider_token
    })[:response][:upload_url]
  end

  def unloaded_photo?
    @unloaded_photo_hash ||= APIResponseParser.parse(@get_upload_server, {
      access_token: @photo.provider_token,
      photo: File.new(@photo_path.path, 'rb')
    }, :post)

    @photo_path.remove!
  end

  def set_profile_photo?
    APIResponseParser.parse(SAVE_PROFILE_PHOTO_URL, {
      access_token: @photo.provider_token,
      server: @unloaded_photo_hash[:server],
      photo: @unloaded_photo_hash[:photo],
      hash: @unloaded_photo_hash[:hash]
    }, :post)
  end

  GET_PHOTO_PROFILE_URL = 'https://api.vkontakte.ru/method/photos.getProfile'
  GET_VK_UPLOAD_SERVER_URL = 'https://api.vkontakte.ru/method/photos.getProfileUploadServer'
  SAVE_PROFILE_PHOTO_URL = 'https://api.vkontakte.ru/method/photos.saveProfilePhoto'
end
