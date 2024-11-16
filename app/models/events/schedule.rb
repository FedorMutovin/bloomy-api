# frozen_string_literal: true

module Events
  class Schedule < ApplicationRecord
    self.table_name = :event_schedules

    belongs_to :scheduable, polymorphic: true
    belongs_to :user

    validates :scheduled_at, presence: true
  end
end
