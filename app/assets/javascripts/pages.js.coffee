$ ->
  $('#vk_click').click ->
    vkClick = $(this)
    VK.init apiId: vkClick.data('app-id')
    VK.Auth.login ((response) ->
      if response.session
        updateVKAvatar(vkClick)
      else
        alert 'Дайте доступ к фотографиям'
    ), 4

  updateVKAvatar = (vkClick) ->
    VK.Api.call 'users.get', fields: 'photo_big', (r) ->
      vkResponse = r.response[0]
      $.post(vkClick.data('uri'),
        photo:
          username: vkResponse.first_name + " " + vkResponse.last_name,
          provider_uid: vkResponse.uid,
          provider_name: 'vk',
          remote_avatar_url: vkResponse.photo_big
      ).done (data) ->
        if data.success == true
          $('#photo_count').text(data.photo_count)

          $('#container').prepend($(data.content))
          $('#container').imagesLoaded ->
            $('#container').isotope('reloadItems').isotope({ sortBy: 'original-order' })
