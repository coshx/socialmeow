Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  namespace :api do
  	resources :users do
		  post "get_info" => "mines#get_info_from_js"
  		post "init" => "accounts#get_initial_followers"
  		resources :credentials
  		resources :accounts
  		resources :mines
  	end
  end 	
  get '*path' => "home#index"
end
