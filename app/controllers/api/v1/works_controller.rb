# frozen_string_literal: true

module Api
  module V1
    class WorksController < BaseController
      def index
        tasks = WorkRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(tasks, each_serializer: WorkSerializer).to_json
      end
    end
  end
end
