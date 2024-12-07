# frozen_string_literal: true

module Tasks
  class UnpostponeService < ApplicationService
    DEFAULT_PARAMS = {
      postponed_until: nil,
      postponed_at: nil,
      status: Status::PENDING
    }.freeze

    def call
      unpostpone!
    end

    private

    def unpostpone!
      tasks = TaskRepository.ready_to_unpostpone

      tasks.each do |task|
        TaskRepository.update(task.id, **DEFAULT_PARAMS)
      end
    end
  end
end
