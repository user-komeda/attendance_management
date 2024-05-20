Rails.application.routes.draw do

  devise_for :users, controllers: {

    registrations: 'users/registrations',

    confirmations: 'users/confirmations',

    sessions: 'users/sessions',

    passwords: 'users/passwords'

  }

  resources :attendances, path: 'users/:user_id/attendances', except: %i[show destroy]
  resource :user_config, path: 'users/:user_id/config', except: %i[index new show destroy], controller: "users_config"

  root 'home#index'

  get '/users/:id/exportCsv', to: 'export_csv#export_csv'
  get '/users/:id/exportXlsx', to: 'export_xlsx#export_xlsx'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
