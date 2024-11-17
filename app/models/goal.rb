# frozen_string_literal: true

class Goal < ApplicationRecord
  include Relatable
  include Reflectable

  belongs_to :user
  has_one :engagement, class_name: 'GoalEngagement', dependent: :destroy

  validates :name, :status, :initiated_at, presence: true
  validates :status, inclusion: { in: Statuses::Goal::ALLOWED_STATUSES }
  validates :priority, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
