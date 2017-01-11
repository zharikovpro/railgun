Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#root'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # for simple probes and stress tests
  # period examples: 10ms, 1s, 1-2m
  # get 'sleep/:period', to: 'sleep#show', id: /^\d+(-(\d+))?(ms|s|m)/
end
