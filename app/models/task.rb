# frozen_string_literal: true

class Task < ApplicationRecord
  include Relatable
  include Scheduable
  include Reflectable
  include EngagementChangable

  belongs_to :user

  validates :status, inclusion: { in: Statuses::Task::ALLOWED_STATUSES }
end
