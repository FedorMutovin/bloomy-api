# frozen_string_literal: true

module Tasks
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @task = create_task!
        add_event_relationship if params[:trigger].present?
        add_schedule if params[:schedule].present?
        add_engagement_change if params[:engagement_changes].present?
      end

      @task
    end

    private

    def create_task!
      TaskRepository.add(
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
        impactable_id: @task.id,
        impactable_type: @task.class.name
      )
    end

    def add_schedule
      Events::ScheduleRepository.add(
        scheduable_id: @task.id,
        scheduable_type: @task.class.name,
        scheduled_at: params[:schedule][:scheduled_at],
        user_id: @task.user_id,
        details: { name: @task.name, description: @task.description }
      )
    end

    def add_engagement_change
      TaskEngagementRepository.add(task_id: @task.id, value: params[:engagement_changes][:value])
    end
  end
end
