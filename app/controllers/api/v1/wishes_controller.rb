# frozen_string_literal: true

module Api
  module V1
    class WishesController < BaseController
      def index
        schedules = WishRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(schedules, each_serializer: WishSerializer).to_json
      end

      def create
        wish = WishRepository.add(params: wishes_params, user_id: current_user.id)
        render json: WishSerializer.new.serialize_to_json(wish)
      end

      private

      def wishes_params
        params.require(:wishes).permit(:title, :description)
      end
    end
  end
end
