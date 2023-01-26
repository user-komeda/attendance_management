Rails.application.routes.draw do
  devise_for :users, controllers: {

    registrations: 'users/registrations',

    confirmations: 'users/confirmations',

    sessions: 'users/sessions',

    passwords: 'users/passwords'

  }

  resources :attendances, path: 'users/:user_id/attendances', except: [:show, :new, :destroy]

  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
