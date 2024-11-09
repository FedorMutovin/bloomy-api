# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      def index
        tasks = TaskRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(tasks, each_serializer: TaskSerializer).to_json
      end

      def create
        task = Tasks::Create.new(
          params: task_params,
          user_id: current_user.id,
          trigger_params: trigger_params
        ).call
        render json: TaskSerializer.new.serialize(task)
      end

      private

      def task_params
        params.require(:task).permit(:name, :description, :priority, :initiated_at)
      end

      def trigger_params
        params.require(:task).fetch(:trigger, {}).permit(:id, :event_type, :name)
      end
    end
  end
end
