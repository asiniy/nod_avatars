module GetOmniauth
  extend ActiveSupport::Concern

  private

  def photo_params
    ohash = request.env['omniauth.auth']

    if params[:provider] == 'vk'
      {
        provider_name: params[:provider],
        provider_uid: ohash['extra']['raw_info']['uid'],
        provider_token: ohash['credentials']['token'],
        username: ohash['extra']['raw_info']['first_name'] + ' ' + ohash['extra']['raw_info']['last_name'],
      }
    end
  end
end
