# frozen_string_literal: true

module Event
  class Relationship < ApplicationRecord
    self.table_name = :event_relationships

    ALLOWED_RELATION_TYPES = %w[triggered caused enabled depended_on influenced related led_to].freeze
    belongs_to :triggerable, polymorphic: true
    belongs_to :impactable, polymorphic: true

    validates :relation_type, presence: true, inclusion: { in: ALLOWED_RELATION_TYPES }
  end
end
