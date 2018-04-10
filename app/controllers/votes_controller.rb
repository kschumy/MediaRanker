class VotesController < ApplicationController

	def index
		@vote = Vote.all
	end

	# Creates a new vote
	def create
		Vote.create(vote_params)
		# redirect_to vote_path(params[:id])
	end

	private

	def work_params
		return params.require(:work).permit(:id, :user_id, :work_id)
	end

end
