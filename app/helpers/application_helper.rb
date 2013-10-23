module ApplicationHelper
  def social_network_path(photo)
    if photo.provider_name == 'vk'
      "http://vk.com/id#{photo.provider_uid}"
    end
  end
end
