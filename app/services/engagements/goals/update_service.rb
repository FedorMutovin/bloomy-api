# frozen_string_literal: true

module Engagements
  module Goals
    class UpdateService < ApplicationService
      param :new_value, reader: :private
      param :goal_id, reader: :private

      def call
        engagement = find_engagement
        update_engagement!(engagement)
      end

      private

      def find_engagement
        GoalEngagementRepository.by_goal_id(goal_id)
      end

      def update_engagement!(engagement)
        last_value = engagement.value
        ActiveRecord::Base.transaction do
          GoalEngagementChangeRepository.add(last_value:, new_value:, engagement: engagement.id)
          GoalEngagementRepository.update(engagement.id, value: new_value)
        end
      end
    end
  end
end
