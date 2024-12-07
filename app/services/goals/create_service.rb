# frozen_string_literal: true

module Goals
  class CreateService < Roots::CreateService
    private

    def create_root!
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

    def after_create(root)
      super
      add_engagement_change(root) if params[:engagement_changes].present?
    end

    def add_engagement_change(goal)
      GoalEngagementRepository.add(goal_id: goal.id, value: params[:engagement_changes][:value])
    end
  end
end
