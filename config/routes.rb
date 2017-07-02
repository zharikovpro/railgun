Rails.application.routes.draw do
  # http://guides.rubyonrails.org/routing.html
  root 'application#root'

  resources :pages, only: :show
  resources :medias, only: :show

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  namespace :api, defaults: {format: :json} do
    post 'graphql' => 'graphql#execute'
    namespace :v1 do
      post 'tokens' => 'user_token#create'

      resources :users, :user_roles, :pages, :snippets, :medias, except: [:new, :edit]
    end
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.try(:developer?) } do
    mount Sidekiq::Web => '/staff/sidekiq'
  end
end
