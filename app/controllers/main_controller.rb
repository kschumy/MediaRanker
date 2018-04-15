class MainController < ApplicationController
	def index
		@top_list = Work.get_top_in_all_categories_sorted(num: 10)
		@top_overall = Work.get_top_overall
	end

end
