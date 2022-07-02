Rails.application.routes.draw do
  root 'time_sheets#index'
  resources :time_sheets, only: %i[index new create destroy]
end
