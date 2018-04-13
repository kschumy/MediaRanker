Rails.application.routes.draw do
	root 'main#index'

	get '/login', to: 'sessions#new', as: 'login_form'
	post '/login', to: 'sessions#create', as: 'login'
	delete '/login', to: 'sessions#destroy', as: 'logout'

	resources :main, only: [:index]
	# resources :works#, except: [:destroy]

	resources :works do #, except: [:destroy]
		resources :votes, only: [:create]
	end

	resources :users, only: [:index, :show, :create]

	# post '/works/id/vote', to: 'votes#create', as: 'cast_vote'
end
