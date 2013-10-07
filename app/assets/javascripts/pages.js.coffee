$ ->
  $('#vk_click').click ->
    vkClick = $(this)
    VK.init apiId: vkClick.data('app-id')
    VK.Api.call 'users.get', fields: 'photo_big', (r) ->
      vk_response = r.response[0]
      $.post(vkClick.data('uri'),
        photo:
          username: vk_response.first_name + " " + vk_response.last_name,
          provider_uid: vk_response.uid,
          provider_name: 'vk',
          remote_avatar_url: vk_response.photo_big
      ).done (data) ->
        if data.success == true
          console.log('Успех')
        else
          console.log('Ошибка')
