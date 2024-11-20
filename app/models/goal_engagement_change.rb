# frozen_string_literal: true

class GoalEngagementChange < ApplicationRecord
  include EngagementChangeable

  belongs_to :engagement,
             class_name: 'GoalEngagement',
             foreign_key: 'goal_engagement_id',
             inverse_of: :engagement_changes
end
