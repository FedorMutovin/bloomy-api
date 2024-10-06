# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Sorting by the created_at field is necessary because we're using UUID as the primary key.
  self.implicit_order_column = "created_at"
end
