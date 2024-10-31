# frozen_string_literal: true

class Wish < ApplicationRecord
  include Relatable

  belongs_to :user
  validates :title, :initiated_at, presence: true
  validates :priority, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
