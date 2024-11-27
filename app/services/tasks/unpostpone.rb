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
      tasks = TaskRepository.ready_to_postpone
      tasks.each do |task|
        TaskRepository.update(task, DEFAULT_PARAMS)
      end
    end
  end
end
