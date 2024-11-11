# frozen_string_literal: true

class Task < ApplicationRecord
  include Relatable
  include Scheduable
  include Reflectable
  include EngagementChangable

  has_many :actions, dependent: :destroy
  belongs_to :user
  belongs_to :goal, optional: true

  validates :status, inclusion: { in: Statuses::Task::ALLOWED_STATUSES }
end
