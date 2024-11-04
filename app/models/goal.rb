# frozen_string_literal: true

class Goal < ApplicationRecord
  ALLOWED_STATUSES = %w[in_progress pending completed postponed declined].freeze
  include Relatable
  include Reflectable
  has_many :actions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :tasks

  validates :name, :status, :initiated_at, presence: true
  validates :status, inclusion: { in: ALLOWED_STATUSES }
  validates :priority, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }
end
