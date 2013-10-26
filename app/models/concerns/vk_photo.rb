require 'rest_client'

module VKPhoto
  extend ActiveSupport::Concern

  included do
    attr_accessor :vk_photo_hash

    def provider_is_vk?
      self.provider_name == 'vk'
    end

    before_validation -> {
      if provider_is_vk?
        photo_urls = JSON.parse(RestClient.get('https://api.vkontakte.ru/method/photos.getProfile', params: { owner_id: self.provider_uid, album_id: '-6', rev: 1, access_token: self.provider_token }))['response'][0].select{ |k,_| %w(src_xxxbig src_xxbig src_xbig src_big src_small src).include?(k) }

        self.remote_avatar_url = photo_urls[photo_urls.keys.reverse.first]
      end
    }

    after_save -> {
      if provider_is_vk?
        get_upload_server_url = "https://api.vkontakte.ru/method/photos.getProfileUploadServer"
        save_profile_photo_url = 'https://api.vkontakte.ru/method/photos.saveProfilePhoto'

        # stroing avatar in the fog
        self.avatar.store!

        # 1. get the remote server address for uploading
        remote_url = JSON.parse(RestClient.get(get_upload_server_url, params: { access_token: self.provider_token}))['response']['upload_url']

        # 2. upload file to the server
        upload_hash = JSON.parse(RestClient.post(remote_url, access_token: self.provider_token, photo: File.new(self.avatar.path, 'rb')))

        # 3. saveProfilePhoto vk api method
        self.vk_photo_hash = JSON.parse(RestClient.post(save_profile_photo_url, server: upload_hash['server'], photo: upload_hash['photo'], hash: upload_hash['hash'], access_token: self.provider_token))['response']['photo_hash']
      end
    }
  end
end
