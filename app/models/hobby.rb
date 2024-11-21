# frozen_string_literal: true

class Hobby < ApplicationRecord
  MAX_LEVEL = 0
  MIN_LEVEL = 4
  MAX_ENGAGEMENT_LEVEL = 0
  MIN_ENGAGEMENT_LEVEL = 4
  self.primary_key = :id

  include Relatable
  belongs_to :user
  validates :name, :initiated_at, presence: true
  validates :skill_level, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
  validates :engagement_level, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
