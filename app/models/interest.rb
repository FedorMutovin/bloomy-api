# frozen_string_literal: true

class Interest < ApplicationRecord
  include Relatable
  belongs_to :user
  validates :name, :initiated_at, presence: true
  validates :engagement_level, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
