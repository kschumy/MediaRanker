class WorksController < ApplicationController
	before_action :find_work, only:[:show, :edit, :update, :destroy]

	def index
		@works = Work.order(votes_count: :desc)
	end

	def show
		@work = Work.find_by(id: params[:id])
	end

	# Creates a new work
	def create
		@work = Work.create(work_params)
		redirect_to work_path(params[:id])
	end

	def new
		@work = Work.new
	end

	def edit
		@work = Work.find_by(id: params[:id])
		@work.update(work_params)
	 	redirect_to work_path(params[:id])
	end



	def update
	end

	def destroy
	end

	private

	def work_params
		return params.require(:work).permit(:id, :title, :category, :publication_year,
			:description, :creator)
	end

end
