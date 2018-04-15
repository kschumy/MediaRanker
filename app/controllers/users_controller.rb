class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@site_user = User.find_by(id: params[:id])
		@voted_on_works = @site_user.votes
		# @voted_on_works = @user.get_all_voted_works # TODO: dependency??
	end

	def create
		raise
		User.create(user_params)
		redirect_to users_path
		# if current_user
		# 	@vote = Vote.new(work: @work, user: User.find(session[:user_id]))
		# 	if @vote.save
		# 		flash[:success] = "Vote cast! for #{@work.title}"
		# 	else
		# 		flash[:alert] << @vote.errors
		# 	end
		# User.create(user_params)
		# redirect_to users_path
		# else
		# 	flash[:alert] = "#{User.find(session[:user_id]).name} must signed out."
		# end
	end

	private

	def user_params
    return params.require(:user).permit(:id, :name)
	end

end
