# frozen_string_literal: true

module Api
  module V1
    class TasksController < BaseController
      def index
        schedules = TaskRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(schedules, each_serializer: TaskSerializer).to_json
      end
    end
  end
end
