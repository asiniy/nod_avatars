source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'pg'

# Rendering
gem 'slim-rails'

# Use SCSS for stylesheets
gem 'sass-rails'

# JS
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Authorization
gem 'devise'
gem 'bcrypt-ruby'
gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4', ref: '6c9e22ab09229b0903942179060c10cf5e3289d8'

# ImageRendering
gem 'fog'
gem 'carrierwave'
gem 'rmagick'
gem 'masonry-rails'

# Social-networks
gem 'omniauth'
gem 'omniauth-vkontakte'
gem 'rest-client' # for vk api

# Server part
gem 'figaro'

group :production do
  gem 'rubocop', require: false
end

group :development do
  gem 'thin'
  gem 'quiet_assets'

  # Deploying
  gem 'capistrano', '2.15.3'
  gem 'rvm-capistrano', '1.4.0'
end
