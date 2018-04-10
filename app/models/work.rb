class Work < ApplicationRecord
	has_many :votes
	validates :title, uniqueness: { scope: :category,
    message: "title: has already been taken" }
end
