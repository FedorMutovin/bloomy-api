# frozen_string_literal: true

class Movie < ApplicationRecord
  ALLOWED_STATUSES = %w[watched waiting].freeze
  ALLOWED_RATINGS = %w[dislike not_worth_it neutral worth_to_watch interesting excited].freeze
  include Reflectable
  include Relatable

  belongs_to :user
  validates :name, :status, presence: true
  validates :status, inclusion: { in: ALLOWED_STATUSES }
  validates :rating, inclusion: { in: ALLOWED_RATINGS, allow_nil: true }
end
