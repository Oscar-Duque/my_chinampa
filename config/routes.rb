Rails.application.routes.draw do

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  match "/422", :to => "errors#unprocessable_entity", :via => :all

  get 'pages/tutorial'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'pages#home'
  
  resources :user_plants do
    resources :reminders, only: %i[create edit update destroy]
  end
  resources :plants, only: %i[index] do
    resources :user_plants, only: %i[new create]
  end

  require "sidekiq/web"
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
