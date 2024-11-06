# frozen_string_literal: true

module Events
  class Relationship < ApplicationRecord
    self.table_name = :event_relationships

    belongs_to :triggerable, polymorphic: true
    belongs_to :impactable, polymorphic: true
  end
end
