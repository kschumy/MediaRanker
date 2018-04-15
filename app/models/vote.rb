class Vote < ApplicationRecord
	belongs_to :user, :counter_cache => true
	belongs_to :work, :counter_cache => true

	validates :user, :work, presence: true
	validates :user, :uniqueness => { :scope => :work, :case_sensitive => false,
		:message => "Already voted for this work"}

	# # Do not delete. Related to question about dependency in user controller and 
	# # user view
	# def get_work_info
	# 	return work.attributes
	# end

end
