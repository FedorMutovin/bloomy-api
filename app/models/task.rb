# frozen_string_literal: true

class Task < ApplicationRecord
  ALLOWED_STATUSES = %w[completed pending in_progress scheduled canceled].freeze
  include Relatable
  include Scheduable
  include Reflectable
  has_many :actions, dependent: :destroy
  belongs_to :user
  belongs_to :goal, optional: true

  validates :name, :status, presence: true
  validates :status, inclusion: { in: ALLOWED_STATUSES }
end
