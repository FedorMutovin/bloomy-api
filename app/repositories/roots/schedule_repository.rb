# frozen_string_literal: true

module Roots
  class ScheduleRepository
    def self.by_user_id(user_id)
      Roots::Schedule.where(user_id:, completed: false).to_a
    end

    def self.add(**params)
      Roots::Schedule.create!(params)
    end
  end
end
