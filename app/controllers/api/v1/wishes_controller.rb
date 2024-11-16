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
        result = validate_params(contract: Events::CreateContract.new, params: params[:wish])

        if result.success?
          task = Wishes::Create.call(result.to_h.merge(user_id: current_user.id))
          render json: WishSerializer.new.serialize(task)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end

      private

      def wish
        @wish ||= WishRepository.by_id(id: params[:id])
      end
    end
  end
end
