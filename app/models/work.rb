class Work < ApplicationRecord
	has_many :votes

	before_validation :remove_white_space_from_title_description_creator

	validates :title, :length => { minimum: 1 }, :uniqueness => {
		:scope => :category, :case_sensitive => false }

	validates :category, :inclusion => { :in => CATEGORIES }

	# TODO: change when migrate to int
	validates :publication_year, inclusion: { :in => (Date.new(0000,1,1)..Date.today) },
		allow_nil: true

	after_validation :nil_blank_values

	# Returns the number of votes the work has.
	def get_vote_count
		return calculate_vote_count
	end

	# TODO: change when migrate to int
	def get_publication_year
		return publication_year.year if !publication_year.nil?
	end

	# PRE: provided num must be an int or nil. Otherwise, throws ArgumentError.
	# Returns the provided num number of top works in all categories.
	def self.get_top_in_all_categories_sorted(num: nil)
		valid_num_or_error(num)
		top_works = {}
		CATEGORIES.each do |work_category|
			top_works[work_category] = get_sorted_in_category(work_category, num)
		end
		return top_works
	end

	# Returns the work with the most votes.
	def self.get_top_overall
		return Work.order(votes_count: :desc).first
	end

	private

	def self.valid_num_or_error(num)
		raise ArgumentError.new("Invalid number") if !num.nil? && !num.is_a?(Integer)
	end

	def self.get_sorted_in_category(work_category, num)
		works_in_order = Work.where(category: work_category).order(votes_count: :desc)
		return num.nil? ? works_in_order : works_in_order.first(num)
	end

	def calculate_vote_count
		return self.votes_count
	end

	def remove_white_space_from_title_description_creator
		[title, description, creator].each do |work_attribute|
			work_attribute.squish! if !work_attribute.nil?
		end
	end

	# TODO: figure out why this does not work when attempting to DRY it up
	def nil_blank_values
		self.description = nil if !self.description.nil? && self.description.blank?
		self.creator = nil if !self.creator.nil? && self.creator.blank?
	end

end

# ** NOT USED IN CURRENT VERSION OF PROGRAM **
# Requires private self.valid_category_or_error(work_category, num)
# # PRE: provided category must be a valid category in CATEGORIES and num must be
# # and int or nil. Otherwise, throws ArgumentError.
# def self.get_top_in_category_sorted(work_category, num: nil)
# 	valid_category_or_error(work_category, num)
# 	return get_sorted_in_category(work_category, num)
# end

# ** NOT USED IN CURRENT VERSION OF PROGRAM **
# Needed by discontinued self.get_top_in_category_sorted(work_category, num: nil)
# def self.valid_category_or_error(work_category, num)
# 	raise ArgumentError.new("Invalid category") if !CATEGORIES.include?(work_category)
# end
