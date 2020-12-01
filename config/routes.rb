Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
  }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :user_plants do
    resources :reminders, only: %i[create edit update destroy]
  end
  resources :plants, only: %i[index] do
    resources :user_plants, only: %i[new create]
  end
end
