NodAvatars::Application.routes.draw do
  root to: 'pages#root'
  resources :photos, only: :create

  get "/auth/:provider/callback" => "photos#new"
  devise_for :users
  ActiveAdmin.routes(self)
end
