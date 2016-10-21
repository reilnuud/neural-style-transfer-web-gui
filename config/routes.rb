Rails.application.routes.draw do
  resources :nsts
  resources :images
  get 'nsts/index'
  root 'nsts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
