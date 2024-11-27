# frozen_string_literal: true

module Roots
  class Unite < ApplicationRecord
    self.table_name = :root_unites

    belongs_to :source, polymorphic: true
    belongs_to :target, polymorphic: true
    belongs_to :user
  end
end
