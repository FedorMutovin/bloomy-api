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

  def self.postponed_tasks(time)
    task_ids = Task.where(postponed_until: ..time).pluck(:id)
    Task.where(id: task_ids)
  end

  def self.update_tasks(tasks, params)
    tasks.each do |task|
      task.update(params)
    end
  end
end
