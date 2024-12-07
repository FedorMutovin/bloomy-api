# frozen_string_literal: true

module Tasks
  class CreateService < Roots::CreateService
    private

    def create_root!
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

    def after_create(root)
      super
      add_schedule(root) if params[:schedule].present?
      add_engagement_change(root) if params[:engagement_changes].present?
    end

    def add_schedule(task)
      Roots::ScheduleRepository.add(
        scheduable_id: task.id,
        scheduable_type: task.class.name,
        scheduled_at: params[:schedule][:scheduled_at],
        user_id: task.user_id,
        details: { name: task.name, description: task.description }
      )
    end

    def add_engagement_change(task)
      TaskEngagementRepository.add(task_id: task.id, value: params[:engagement_changes][:value])
    end
  end
end
