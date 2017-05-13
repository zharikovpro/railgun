Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#root'

  resources :pages, only: :show
  resources :medias, only: :show

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  # authenticate :user do
  #   resources :users, only: [] do
  #     resource :reincarnation, only: :create
  #   end
  #   resource :reincarnation, only: :destroy
  # end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post 'tokens' => 'user_token#create'

      [:pages, :snippets, :medias].each do |resource|
        resources resource, except: [:new, :edit]
      end
    end
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |user| user.try(:developer?) } do
    mount Sidekiq::Web => '/staff/sidekiq'
  end
end
