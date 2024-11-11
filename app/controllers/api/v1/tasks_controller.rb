# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      def index
        tasks = TaskRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(tasks, each_serializer: TaskSerializer).to_json
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
    end
  end
end
