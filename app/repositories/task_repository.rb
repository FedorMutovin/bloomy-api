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

  def self.ready_to_postpone
    Task.where(postponed_until: ..DateTime.current).to_a
  end

  def self.update(task, params)
    task.update(params)
  end
end
