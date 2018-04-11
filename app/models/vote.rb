class Vote < ApplicationRecord
	belongs_to :user
	belongs_to :work

	validates :user, :work, presence: true#, allow_nil: false
end
