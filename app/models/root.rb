# frozen_string_literal: true

class Root < ApplicationRecord
  MAX_PRIORITY = 0
  MIN_PRIORITY = 4
  AVAILABLE_TYPES = %w[Task Wish Thought Action Goal Decision
                       Activity Hobby Travel Interest IndependentEvent
                       Incident Movie Conflict].freeze
  self.primary_key = :id
  def readonly?
    true
  end
end
