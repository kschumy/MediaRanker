class VotesController < ApplicationController

	def index
		@vote = Vote.all
	end

	# Creates a new vote
	def create
		# Vote.create(vote_params)
		# redirect_to vote_path(params[:id])
		raise
		@work = find_work
		if current_user
			@vote = Vote.new(work: @work, user: User.find(session[:user_id]))
			if @vote.save
				flash[:success] = "Vote cast for #{@work.title}!"
			else
				flash[:alert] = @vote.errors
			end
		end
		redirect_to works_path
	end

	# Creates a new vote
	def new
		raise
		# Vote.create(vote_params)
		# redirect_to vote_path(params[:id])
	end

	private

	def work_params
		return params.require(:work).permit(:id, :user_id, :work_id)
	end

end
