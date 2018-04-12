class Work < ApplicationRecord
	# CATEGORIES = %w[movie book album]

	has_many :votes

	before_validation :remove_white_space_from_title_description_creator

	# validates :title, :valid_string

	validates :title, :length => { minimum: 1 }, :uniqueness => {
		:scope => :category, :case_sensitive => false, :message => "fucked up title"}

	validates :category, :inclusion => { :in => CATEGORIES }

	validates :publication_year, inclusion: { :in => (Date.new(0000,1,1)..Date.today) },
		allow_nil: true

	after_validation :nil_blank_values

	def get_vote_count
		return calculate_vote_count
	end

	def get_publication_year
		return publication_year.year if !publication_year.nil?
	end

	def self.get_sorted(category, num: nil)
		valid_category_and_num_or_error(category, num)
		works_in_order = Work.where(category: category).order(votes_count: :desc)
		return num.nil? ? works_in_order : works_in_order.first(num)
	end


	private

	def self.valid_category_and_num_or_error(category, num)
		if !CATEGORIES.include?(category) || (!num.nil? && !num.is_a?(Integer))
			raise ArgumentError.new("Invalid category #{category} or num #{num}")
		end
	end

	def calculate_vote_count
		return self.votes.count
	end

	def remove_white_space_from_title_description_creator
		[self.title, self.description, self.creator].each do |work_attribute|
			work_attribute.squish! if !work_attribute.nil?
		end
	end

	def nil_blank_values
		self.description = nil if !self.description.nil? && self.description.blank?
		self.creator = nil if !self.creator.nil? && self.creator.blank?
	end

	# def publication_year_if_bad
	# 	if publication_year.present? && (!publication_year.is_a?(Date) || publication_year > Date.today)
  #     errors.add(:publication_year, "invalid publication year")
  # 	end
	# end

end
