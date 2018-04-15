class User < ApplicationRecord
	has_many :votes

	before_validation :remove_white_space_from_name

	validates :name, :length => { minimum: 1 }, :uniqueness => {
		:case_sensitive => false }

	def get_vote_count
		return calculate_vote_count
	end

	# DO NOT DELETE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# You need to ask if this is approach (or similar) is better for reducing
	# dependencies
	# def get_all_voted_works
	# 	return collect_all_voted_works
	# end

	private

	def remove_white_space_from_name
		self.name.squish! if !self.name.nil?
	end

	def calculate_vote_count
		return self.votes_count
	end

	# DO NOT DELETE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# See note above
	# def collect_all_voted_works
	# 	works_info = []
	# 	votes.each { |vote| works_info << vote.get_work_info }
	# 	return works_info
	# end

end
