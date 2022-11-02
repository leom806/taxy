class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :group_hourly, -> { group("TO_CHAR(created_at, 'yyyy-mm-dd HH:MM')") }
end
