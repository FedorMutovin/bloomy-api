# frozen_string_literal: true

module Events
  class ScheduleSerializer < Panko::Serializer
    attributes :id, :scheduled_at, :scheduable_type, :scheduable_id, :details, :completed
  end
end
