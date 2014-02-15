module ApplicationHelper
  def social_network_url(photo)
    case photo.provider_name
    when 'vk' then "http://vk.com/id#{photo.provider_uid}"
    when 'fb' then "http://facebook.com/profile.php?id=#{photo.provider_uid}"
    when 'ok' then "http://odnoklassniki.ru/profile/#{photo.provider_uid}"
    else raise 'no such provider'
    end
  end

  def social_network_icon(photo)
    case photo.provider_name
    when 'vk' then image_tag('vk_icon.png')
    when 'fb' then image_tag('fb_icon.gif')
    when 'ok' then image_tag('ok_icon.png')
    else raise 'no such provider'
    end
  end
end
