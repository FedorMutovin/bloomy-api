# frozen_string_literal: true

class TaskRepository
  def self.by_user_id(user_id:)
    Task.where(user_id:, closed_at: nil, postponed_at: nil).order(priority: :asc).to_a
  end

  def self.add(**params)
    Task.create!(**params)
  end

  def self.by_id(id:)
    Task.find(id)
  end

  def self.unpostpone_tasks
    time_threshold = DateTime.current + 5.minutes
    tasks_to_unpostpone = Task.where(postponed_until: ..time_threshold)

    tasks_to_unpostpone.each do |task|
      task.update(
        postponed_until: nil,
        postponed_at: nil,
        status: Status::PENDING
      )
    end
  end
end
