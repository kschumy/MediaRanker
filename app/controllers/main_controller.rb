class MainController < ApplicationController
	def index
		@top_list = Work.get_top_in_all_categories_sorted(num: 10)
	end
end
