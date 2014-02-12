module ApplicationHelper
  def social_network_path(photo)
    if photo.provider_name == 'vk'
      "http://vk.com/id#{photo.provider_uid}"
    end
  end

  def social_network_icon(photo)
    case photo.provider_name
    when 'vk' then image_tag('vk_icon.png')
    else raise 'no such provider'
    end
  end
end
