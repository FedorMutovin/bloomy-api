# frozen_string_literal: true

module Api
  module V1
    class EventsController < BaseController
      def index
        events = EventRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(events, each_serializer: EventSerializer).to_json
      end
    end
  end
end
