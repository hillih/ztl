class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.per_page = 20
end
