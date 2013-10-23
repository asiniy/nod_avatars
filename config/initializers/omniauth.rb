Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VK_APP_ID'], ENV['VK_APP_TOKEN'], scope: 'photos', name: 'vk'
end
