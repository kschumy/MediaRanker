class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def valid_string
  #   :length => { minimum: 1 }, :uniqueness => {
  # 		:scope => :category, :case_sensitive => false, :message => "fucked up title"}
  # end
end
