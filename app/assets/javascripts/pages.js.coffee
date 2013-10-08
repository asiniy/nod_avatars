$ ->
  $('#vk_click').click ->
    vkClick = $(this)
    VK.init apiId: vkClick.data('app-id')
    VK.Api.call 'users.get', fields: 'photo_big', (r) ->
      vkResponse = r.response[0]
      $.post(vkClick.data('uri'),
        photo:
          username: vkResponse.first_name + " " + vkResponse.last_name,
          provider_uid: vkResponse.uid,
          provider_name: 'vk',
          remote_avatar_url: vkResponse.photo_big
      ).done (data) ->
        if data.photo.uid != null
          console.log('Сохранено')
        else
          console.log('Ошибка')
