Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'main#index'
	resources :users, only: [:index, :show, :create]
	resources :works, except: [:destroy]
	# resources :votes, only: [:create]
	post "/works/:id/vote", to: "works#cast_vote", as: "cast_vote"
end
