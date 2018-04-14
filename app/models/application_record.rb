class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  CATEGORIES = %w[movie book album]

end
