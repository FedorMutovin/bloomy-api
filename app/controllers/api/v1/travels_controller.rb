# frozen_string_literal: true

module Api
  module V1
    class TravelsController < BaseController
      def index
        travels = TravelRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(travels, each_serializer: TravelSerializer).to_json
      end
    end
  end
end
