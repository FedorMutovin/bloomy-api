# frozen_string_literal: true

class Task < ApplicationRecord
  ALLOWED_STATUSES = %w[completed pending in_progress postponed scheduled canceled].freeze
  include Relatable
  include Scheduable
  include Reflectable
  has_many :actions, dependent: :destroy
  belongs_to :user
  belongs_to :goal, optional: true

  validates :name, :status, :initiated_at, presence: true
  validates :status, inclusion: { in: ALLOWED_STATUSES }
  validates :priority, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
