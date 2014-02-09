require 'rest_client'

class APIResponseParser
  def self.parse(path, options, method = :get)
    JSON.parse(RestClient.send(method, path, options)).deep_symbolize_keys
  end
end
