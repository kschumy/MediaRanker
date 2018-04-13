class SessionsController < ApplicationController

	def create
		@user = User.find_by(name: params[:user][:name])
		if @user
			session[:user_id] = @user.id
			flash[:success] = "Welcome back #{@user.name}"
		else
			@user = User.create(name: params[:user][:name])
			session[:user_id] = @user.id
			flash[:success] = "Welcome, #{@user.name}"
		end
		redirect_to root_path
	end

	def new
		@user = User.new
		# @book.author = Author.find(params[:author_id])
		# @action = author_books_path(params[:author_id])
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You logged out"
		redirect_to root_path
	end
end
