# frozen_string_literal: true

class Event < ApplicationRecord
  self.primary_key = :id
  def readonly?
    true
  end
end
