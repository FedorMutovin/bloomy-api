# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      def index
        tasks = TaskRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(tasks, each_serializer: TaskSerializer).to_json
      end
    end
  end
end
