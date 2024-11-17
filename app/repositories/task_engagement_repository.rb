# frozen_string_literal: true

class TaskEngagementRepository
  def self.by_task_id(task_id)
    TaskEngagement.find_by(task_id:)
  end

  def self.add(**params)
    TaskEngagement.create!(**params)
  end

  def self.update(id, **params)
    TaskEngagement.find(id).update!(**params)
  end
end
