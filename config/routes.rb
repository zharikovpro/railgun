Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#root'

  devise_for :employees, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad

  authenticate :employee do
    resources :users, only: [] do
      resource :reincarnation, only: :create
    end
    resource :reincarnation, only: :destroy
  end

  require 'sidekiq/web'
  authenticate :employee, lambda { |e| e.admin? } do
    mount Sidekiq::Web => "/#{ENV.fetch('ADMIN_NAMESPACE', :cowboy)}/sidekiq"
  end

  # for simple probes and stress tests
  # period examples: 10ms, 1s, 1-2m
  # get 'sleep/:period', to: 'sleep#show', id: /^\d+(-(\d+))?(ms|s|m)/
end
