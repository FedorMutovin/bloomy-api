# frozen_string_literal: true

module Api
  module V1
    class SchedulesController < BaseController
      def index
        schedules = Event::ScheduleRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(schedules, each_serializer: Event::ScheduleSerializer).to_json
      end
    end
  end
end
