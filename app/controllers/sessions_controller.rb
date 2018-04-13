class SessionsController < ApplicationController

	def create
		@user = User.find_by(name: params[:user][:name])
		if @user
			set_session_and_alert("Welcome back, #{@user.name}", session_value: @user.id)
			# session[:user_id] = @user.id
			# flash[:success] = "Welcome back, #{@user.name}"
			# redirect_to root_path
		else
			@user = User.new(name: params[:user][:name])
			if @user.save
				set_session_and_alert("Welcome, #{@user.name}", session_value: @user.id)
				# session[:user_id] = @user.id
				# flash[:success] = "Welcome, #{@user.name}"
				# redirect_to root_path
			else
				flash[:alert] = @user.errors
				redirect_to :login
			end
		end
	end

	def new
		@user = User.new
		# @book.author = Author.find(params[:author_id])
		# @action = author_books_path(params[:author_id])
	end

	def destroy
		set_session_and_alert("You logged out")
		# session[:user_id] = nil
		# flash[:success] = "You logged out"
		# redirect_to root_path
	end

	private

	def set_session_and_alert(message, session_value: nil)
		session[:user_id] = session_value
		flash[:success] = message
		redirect_to root_path
	end

	def welcome_user(message)
		set_session_and_alert(message, session_value: @user.id)
		# session[:user_id] = @user.id
		# flash[:success] = message << "#{@user.name}"
		# redirect_to root_path
	end

end
