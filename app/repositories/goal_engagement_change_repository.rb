# frozen_string_literal: true

class GoalEngagementChangeRepository
  def self.add(**params)
    GoalEngagementChange.create!(params)
  end
end
