class Work < ApplicationRecord
	has_many :votes

	before_validation :squish_title_and_description

	validates :title, :length => { minimum: 1 }, :uniqueness => {
		:scope => :category, :case_sensitive => false }

	validates :category, :inclusion => { :in => %w[movie book album] }

	def get_vote_count
		return calculate_vote_count
	end

	private

	def calculate_vote_count
		return votes.size
	end

	def squish_title_and_description
		self.title = self.title.squish if !self.title.nil? # TODO: need? Validated above
		self.description = self.description.squish if !self.description.nil?
	end

end
