class VotesController < ApplicationController

	def index
		@vote = Vote.all
	end

	# Creates a new vote
	def create
		# Vote.create(vote_params)
		@work = find_work
		if current_user
			@vote = Vote.new(work: @work, user: User.find(session[:user_id]))
			if @vote.save
				flash[:success] = "Vote cast! for #{@work.title}"
			else
				flash[:alert] = @vote.errors
			end
		end
		redirect_to works_path
	end

	# Creates a new vote
	# def new
	# 	# raise
	# 	Vote.create(vote_params)
	# 	# redirect_to vote_path(params[:id])
	# end

	private

	def vote_params
		return params.require(:work).permit(:id, :user_id, :work_id)
	end

end
# def cast_vote
	# if current_user
	# 	raise
	# 	Vote.create(work: @work, user: User.find(session[:user_id]))
	# 	flash[:success] = "Vote cast! for #{@work}"
	# else
	# 	flash[:alert] = "You must log in to do that"
	# end
	# redirect_to works_path
# end
