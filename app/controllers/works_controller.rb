class WorksController < ApplicationController

	def index
		@work = Work.all
	end

	def show
		@work = Work.find_by(id: params[:id])
	end

	# Creates a new work
	def create
		Work.create(work_params)
		redirect_to work_path(params[:id])
	end

	def edit
		@work = Work.find_by(id: params[:id])
		@work.update(work_params)
	 	redirect_to work_path(params[:id])
	end

	private

	def work_params
		return params.require(:work).permit(:id, :title, :category, :publication_year,
			:description, :creator)
	end

end
