class MainController < ApplicationController
	def index
		@movies = Work.get_sorted("movie", num: 10)
		@books = Work.get_sorted("book", num: 10)
		@albums = Work.get_sorted("album", num: 10)
	end
end
