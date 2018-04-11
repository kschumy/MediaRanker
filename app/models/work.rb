class Work < ApplicationRecord
	has_many :votes

	before_validation :squish_title_and_description

	validates :title, :length => { minimum: 1 }, :uniqueness => {
		:scope => :category, :case_sensitive => false, :message => "fucked up title"}

	validates :category, :inclusion => { :in => %w[movie book album] }

	validates :publication_year, inclusion: { :in => (Date.new(0000,1,1)..Date.today) },
		allow_nil: true

	# validate :publication_year_if_bad

	def get_vote_count
		return calculate_vote_count
	end

	private

	def calculate_vote_count
		return votes.size
	end

	def squish_title_and_description
		# [self.title, self.description, self.creator].each do |work_attribute|
		# 	work_attribute = work_attribute.squish if !work_attribute.nil?
		# 	# work_attribute.nil? ? next : work_attribute = work_attribute.squish
		# end
		self.title = self.title.squish if !self.title.nil? # TODO: need? Validated above
		self.description = self.description.squish if !self.description.nil?
		self.creator = self.creator.squish if !self.creator.nil?
	end

	# def publication_year_if_bad
	# 	if publication_year.present? && (!publication_year.is_a?(Date) || publication_year > Date.today)
  #     errors.add(:publication_year, "invalid publication year")
  # 	end
	# end

end
