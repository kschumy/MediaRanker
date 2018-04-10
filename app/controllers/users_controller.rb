class UsersController < ApplicationController

	def index
		@user = User.all
	end


	def show
		@user = User.find_by(id: params[:id])
	end

	# Creates a new user
	def create
		User.create(user_params)
		redirect_to users_path
	end

	private

	def user_params
    return params.require(:user).permit(:id, :name)
	end

end
