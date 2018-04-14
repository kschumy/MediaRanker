class VotesController < ApplicationController

	# Creates a new vote
	def create
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

	private

	def work_params
		return params.require(:work).permit(:id, :user_id, :work_id)
	end

	def find_work
    @work = Work.find_by(id: params[:work_id])
	end

end
