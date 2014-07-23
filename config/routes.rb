Rails.application.routes.draw do
  resources :notes, only: [:create]
end
