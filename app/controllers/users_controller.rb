class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@site_user = User.find_by(id: params[:id])
		# @voted_on_works = @site_user.get_all_voted_works # TODO: dependency?? See view
	end

	private

	def user_params
    return params.require(:user).permit(:id, :name)
	end

end
