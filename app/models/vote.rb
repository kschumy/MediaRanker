class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :work, :counter_cache => true

	validates :user, :work, presence: true#, allow_nil: false
end
