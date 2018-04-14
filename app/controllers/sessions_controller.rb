class SessionsController < ApplicationController

	def create
		@user = User.find_by(name: params[:user][:name])
		if @user
			set_session_and_alert("Welcome back, #{@user.name}", session_value: @user.id)
		else
			@user = User.new(name: params[:user][:name])
			if @user.save
				set_session_and_alert("Welcome, #{@user.name}", session_value: @user.id)
			else
				flash[:alert] = @user.errors
				redirect_to :login
			end
		end
	end

	def new
		@user = User.new
	end

	def destroy
		set_session_and_alert("You logged out")
	end

	private

	def set_session_and_alert(message, session_value: nil)
		session[:user_id] = session_value
		flash[:success] = message
		redirect_to root_path
	end

	def welcome_user(message)
		set_session_and_alert(message, session_value: @user.id)
	end

end
