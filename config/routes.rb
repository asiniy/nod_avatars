NodAvatars::Application.routes.draw do
  root to: 'pages#root'

  devise_for :users
  ActiveAdmin.routes(self)
end
