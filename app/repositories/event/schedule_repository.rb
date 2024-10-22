# frozen_string_literal: true

module Event
  class ScheduleRepository
    def self.by_user_id(user_id:)
      Event::Schedule.where(user_id:).to_a
    end

    def self.scheduled_by_user_id(user_id:)
      Event::Schedule.where(user_id:, completed: false).to_a
    end
  end
end
