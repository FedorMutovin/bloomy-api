# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Sorting by the initiated_at field is necessary because we're using UUID as the primary key.
  # self.implicit_order_column = 'initiated_at'
  # TODO: we do sorting manually in repos
end
