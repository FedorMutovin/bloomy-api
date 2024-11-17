# frozen_string_literal: true

module Goals
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @goal = create_goal!
        add_event_relationship if params[:trigger].present?
        add_engagement_change if params[:engagement_changes].present?
      end

      @goal
    end

    private

    def create_goal!
      GoalRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        description: params[:description],
        priority: params[:priority],
        initiated_at: params[:initiated_at],
        started_at: params[:started_at],
        status: params[:status]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @goal.id,
        impactable_type: @goal.class.name
      )
    end

    def add_engagement_change
      GoalEngagementRepository.add(goal_id: @goal.id, value: params[:engagement_changes][:value])
    end
  end
end
