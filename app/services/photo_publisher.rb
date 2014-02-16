require 'rest_client'

class PhotoPublisher
  def id
    @photo.try(:id)
  end

  def initialize(ohash)
    @photo = Photo.new(parse_hash(ohash))
  end

  def save
    published? && @photo.save
  end

  private

  def parse_hash(ohash)
    if ohash['provider'] == 'vk'
      {
        provider_name: 'vk',
        provider_uid: ohash['extra']['raw_info']['id'],
        provider_token: ohash['credentials']['token'],
        username: ohash['extra']['raw_info']['first_name'] + ' ' + ohash['extra']['raw_info']['last_name'],
      }
    else
      raise 'undefined authorizer'
    end
  end

  def published?
    @published ||= send("published_at_#{@photo.provider_name}?")
  end

  def published_at_vk?
    @published_at_vk ||= publish_at_vk
  end

  def publish_at_vk
    avatar_urls = APIResponseParser.parse(GET_PHOTO_PROFILE_URL, params: {
        owner_id: @photo.provider_uid,
        album_id: '-6',
        rev: 1,
        access_token: @photo.provider_token
    })[:response][0].symbolize_keys.select{ |k,_| k.match(/src/) }

    @photo.remote_avatar_url = avatar_urls[avatar_urls.keys.reverse.first]
    @photo_path = AvatarsUploader.new
    @photo_path.download!(avatar_urls[avatar_urls.keys.reverse.first])
    @photo_path.store!

    remote_url = APIResponseParser.parse(GET_VK_UPLOAD_SERVER_URL, params: {
      access_token: @photo.provider_token
    })[:response][:upload_url]

    upload_hash = APIResponseParser.parse(remote_url, {
      access_token: @photo.provider_token,
      photo: File.new(@photo_path.path, 'rb')
    }, :post)

    @photo_path.remove!

    vk_photo_hash = APIResponseParser.parse(SAVE_PROFILE_PHOTO_URL, {
      access_token: @photo.provider_token,
      server: upload_hash[:server],
      photo: upload_hash[:photo],
      hash: upload_hash[:hash]
    }, :post)

    return vk_photo_hash.has_key?(:response)
  end

  GET_PHOTO_PROFILE_URL = 'https://api.vkontakte.ru/method/photos.getProfile'
  GET_VK_UPLOAD_SERVER_URL = 'https://api.vkontakte.ru/method/photos.getProfileUploadServer'
  SAVE_PROFILE_PHOTO_URL = 'https://api.vkontakte.ru/method/photos.saveProfilePhoto'
end
