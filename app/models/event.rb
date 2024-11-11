# frozen_string_literal: true

class Event < ApplicationRecord
  MAX_PRIORITY = 0
  MIN_PRIORITY = 4
  self.primary_key = :id
  def readonly?
    true
  end
end
