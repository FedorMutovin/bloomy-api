# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      before_action :task, only: %i[show]
      def index
        tasks = TaskRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(tasks, each_serializer: TaskSerializer).to_json
      end

      def show
        render json: TaskSerializer.new.serialize_to_json(task)
      end

      def create
        result = validate_params(contract: Tasks::CreateContract.new, params: params[:task])

        if result.success?
          task = Tasks::Create.call(result.to_h.merge(user_id: current_user.id))
          render json: TaskSerializer.new.serialize(task)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end

      private

      def task
        @task ||= TaskRepository.by_id(id: params[:id])
      end
    end
  end
end
