# frozen_string_literal: true

module Api
  module V1
    class SchedulesController < BaseController
      def index
        schedules = Roots::ScheduleRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(schedules, each_serializer: Roots::ScheduleSerializer).to_json
      end
    end
  end
end
