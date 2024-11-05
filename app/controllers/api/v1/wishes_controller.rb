# frozen_string_literal: true

module Api
  module V1
    class WishesController < BaseController
      before_action :wish, only: %i[show]
      def index
        wishes = WishRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(wishes, each_serializer: WishSerializer).to_json
      end

      def show
        render json: WishSerializer.new.serialize_to_json(wish)
      end

      def create
        wish = WishRepository.add(params: wishes_params.merge(user_id: current_user.id))
        render json: WishSerializer.new.serialize_to_json(wish)
      end

      private

      def wishes_params
        params.require(:wish).permit(:name, :description, :priority, :initiated_at)
      end

      def wish
        @wish ||= WishRepository.by_id(id: params[:id])
      end
    end
  end
end
