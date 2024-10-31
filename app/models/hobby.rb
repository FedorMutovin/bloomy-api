# frozen_string_literal: true

class Hobby < ApplicationRecord
  include Relatable
  belongs_to :user
  validates :name, :initiated_at, presence: true
  validates :skill_level, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
  validates :engagement_level, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
