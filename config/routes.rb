Rails.application.routes.draw do
  resources :manufacturers, only: [:index]
end
