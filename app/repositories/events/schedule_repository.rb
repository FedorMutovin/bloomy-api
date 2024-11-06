# frozen_string_literal: true

module Events
  class ScheduleRepository
    def self.by_user_id(user_id:)
      Events::Schedule.where(user_id:, completed: false).to_a
    end
  end
end