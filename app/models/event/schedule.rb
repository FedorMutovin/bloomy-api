# frozen_string_literal: true

module Event
  class Schedule < ApplicationRecord
    self.table_name = :event_schedules

    has_paper_trail

    belongs_to :scheduable, polymorphic: true

    validates :scheduled_at, presence: true
  end
end
