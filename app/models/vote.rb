class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :work, :counter_cache => true

	validates :user, :work, presence: true
	validates :user, :uniqueness => { :scope => :work, :case_sensitive => false,
		:message => "Already voted for this work"}
end
