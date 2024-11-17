# frozen_string_literal: true

class GoalEngagementRepository
  def self.by_goal_id(goal_id)
    GoalEngagement.find_by(goal_id:)
  end

  def self.add(**params)
    GoalEngagement.create!(**params)
  end

  def self.update(id, **params)
    GoalEngagement.find(id).update!(**params)
  end
end
