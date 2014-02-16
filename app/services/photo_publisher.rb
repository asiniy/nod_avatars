require 'rest_client'

class PhotoPublisher
  def initialize(ohash)
    @photo = Photo.new(OmniauthResponseParser.parse(ohash))
  end

  def id
    @photo.try(:id)
  end

  def save
    published? && @photo.save
  end

  private

  def published?
    @social_publisher ||= Publishers.const_get(@photo.provider_name.capitalize).new(@photo)
    @published ||= @social_publisher.published?
  end
end
