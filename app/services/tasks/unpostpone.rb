# frozen_string_literal: true

module Tasks
  class Unpostpone < ApplicationService
    DEFAULT_PARAMS = {
      postponed_until: nil,
      postponed_at: nil,
      status: Status::PENDING
    }.freeze

    def call
      unpostponed
    end

    private

    def unpostponed
      tasks = TaskRepository.postponed_tasks(postponed_time)
      TaskRepository.update_tasks(tasks, DEFAULT_PARAMS)
    end

    def postponed_time
      DateTime.current + 5.minutes
    end
  end
end
