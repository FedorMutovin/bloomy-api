# frozen_string_literal: true

module Event
  class Reflection < ApplicationRecord
    self.table_name = :event_reflections

    belongs_to :reflectable, polymorphic: true
    validates :description, presence: true
  end
end