# frozen_string_literal: true

class GoalEngagementRepository
  class << self
    def by_goal_id(goal_id)
      GoalEngagement.find_by(goal_id:)
    end

    def add(**params)
      GoalEngagement.create!(params)
    end

    def update(id, **params)
      GoalEngagement.find(id).update!(**params)
    end
  end
end
