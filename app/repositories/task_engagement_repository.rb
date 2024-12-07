# frozen_string_literal: true

class TaskEngagementRepository
  class << self
    def by_task_id(task_id)
      TaskEngagement.find_by(task_id:)
    end

    def add(**params)
      TaskEngagement.create!(params)
    end

    def update(id, **params)
      TaskEngagement.find(id).update!(params)
    end
  end
end
