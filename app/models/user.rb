class User < ApplicationRecord
	has_many :votes

	before_validation :remove_white_space_from_name

	validates :name, :length => { minimum: 1 }, :uniqueness => {
		:case_sensitive => false }

	private

	def remove_white_space_from_name
		self.name.squish! if !self.name.nil?
	end

end
