# frozen_string_literal: true

module Roots
  class Relationship < ApplicationRecord
    self.table_name = :event_relationships

    belongs_to :triggerable, polymorphic: true
    belongs_to :impactable, polymorphic: true
    belongs_to :user
  end
end
