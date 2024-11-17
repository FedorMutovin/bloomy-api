# frozen_string_literal: true

class TaskEngagementChange < ApplicationRecord
  MIN_CHANGE_VALUE = 0
  MAX_CHANGE_VALUE = 3

  belongs_to :engagement,
             class_name: 'TaskEngagement',
             foreign_key: 'task_engagement_id',
             inverse_of: :engagement_changes
end
