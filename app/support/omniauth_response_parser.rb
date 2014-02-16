class OmniauthResponseParser
  def self.parse(ohash)
    send("parse_#{ohash['provider']}", ohash)
  end

  def self.parse_vk(ohash)
    {
      provider_name: 'vk',
      provider_uid: ohash['extra']['raw_info']['id'],
      provider_token: ohash['credentials']['token'],
      username: ohash['extra']['raw_info']['first_name'] + ' ' + ohash['extra']['raw_info']['last_name']
    }
  end
end
