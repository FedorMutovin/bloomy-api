# frozen_string_literal: true

class TaskEngagement < ApplicationRecord
  belongs_to :task

  has_many :engagement_changes, class_name: 'TaskEngagementChange', dependent: :destroy, inverse_of: :engagement
end
