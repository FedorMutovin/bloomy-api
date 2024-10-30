# frozen_string_literal: true

module Api
  module V1
    class WishesController < BaseController
      def index
        schedules = WishRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(schedules, each_serializer: WishSerializer).to_json
      end
    end
  end
end
