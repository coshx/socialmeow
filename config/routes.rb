Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  namespace :api do
  	resources :users do
  		resources :credentials
  		resources :accounts
  	end
  end 	
  get '*path' => "home#index"
end
