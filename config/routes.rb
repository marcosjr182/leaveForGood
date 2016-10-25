Rails.application.routes.draw do

  scope '/admin', as: :admin do
    get '/', to: "admin#index"
    get 'organizations', to: "admin#organizations"
    get 'donations', to: "admin#donations"
    get 'users', to: "admin#users"
    get 'match/:donation_id', to: "admin#match"
  	post 'match/:donation_id', to: "admin#confirm_match", as: "confirm_match"
  end 

	root to: "donations#index"
  resources :donations do
  	get "/update_status", to: "donations#status_update", as: :status_update
  	resources :foods
  end
  
	resource :organization
	
  devise_for :users, :controllers => { registrations: 'registrations' }
end
