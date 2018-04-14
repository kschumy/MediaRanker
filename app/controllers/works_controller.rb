class WorksController < ApplicationController
	# before_action :find_work, only:[:show, :edit, :update, :destroy, :cast_vote]

	def index
		@all_works_sorted_in_categories = Work.get_top_in_all_categories_sorted
	end

	def show
		@work = Work.find_by(id: params[:id])
	end

	# Creates a new work
	def create
		@work = Work.new(work_params)
		if @work.save
			flash[:success] = "Successfully created #{@work.category} #{@work.id}"
			redirect_to work_path(id: @work.id)
		else
			flash[:alert] = @work.errors
			redirect_back(fallback_location: works_path)
		end
	end

	def new
		@category_list = CATEGORIES
		@work = Work.new
	end

	def edit
		@work = Work.find_by(id: params[:id])
		@work.update(work_params)
	 	redirect_to work_path(params[:id])
	end

	def cast_vote
		if current_user
			@vote = Vote.new(work: @work, user: User.find(session[:user_id]))
			if @vote.save
				flash[:success] = "Vote cast for #{@work.title}!"
			else
				flash[:alert] = @vote.errors
			end
		else
			flash[:alert] = "You must log in to do that."
		end
		redirect_to works_path
	end

	def update
	end

	def destroy
	end

	private

	def find_work
    @work = Work.find_by(id: params[:id])
  end

	def work_params
		return params.require(:work).permit(:id, :title, :category, :publication_year,
			:description, :creator)
	end

end
