NodAvatars::Application.routes.draw do
  root to: 'pages#root'
  resources :photos, only: :create

  devise_for :users
  ActiveAdmin.routes(self)
end
