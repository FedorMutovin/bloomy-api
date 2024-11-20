# frozen_string_literal: true

class TaskEngagementChange < ApplicationRecord
  include EngagementChangeable

  belongs_to :engagement,
             class_name: 'TaskEngagement',
             foreign_key: 'task_engagement_id',
             inverse_of: :engagement_changes
end
