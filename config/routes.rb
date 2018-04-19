Rails.application.routes.draw do
	root to: 'main#index'

	get '/login', to: 'sessions#new', as: 'login_form'
	post '/login', to: 'sessions#create', as: 'login'
	delete '/login', to: 'sessions#destroy', as: 'logout'

	resources :users, only: [:index, :show, :create]
	resources :works do
		resources :votes, only: [:create]
	end


	# resources :votes, only: [:new, :create, :destroy]
	# get '/works/:id/vote', to: 'works#cast_vote', as: 'cast_vote'
end
