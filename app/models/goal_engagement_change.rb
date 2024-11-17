# frozen_string_literal: true

class GoalEngagementChange < ApplicationRecord
  MIN_CHANGE_VALUE = 0
  MAX_CHANGE_VALUE = 3

  belongs_to :engagement,
             class_name: 'GoalEngagement',
             foreign_key: 'goal_engagement_id',
             inverse_of: :engagement_changes
end
