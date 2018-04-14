class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  CATEGORIES = %w[album book movie]

end
