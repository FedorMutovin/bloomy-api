# frozen_string_literal: true

class GoalEngagement < ApplicationRecord
  belongs_to :goal

  has_many :engagement_changes, class_name: 'GoalEngagementChange', dependent: :destroy, inverse_of: :engagement
end
