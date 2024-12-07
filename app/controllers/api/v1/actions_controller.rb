# frozen_string_literal: true

module Api
  module V1
    class ActionsController < BaseController
      def index
        actions = ActionRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(actions, each_serializer: ActionSerializer).to_json
      end

      def create
        result = validate_params(contract: Roots::CreateContract.new, params: params[:root_action])

        if result.success?
          action = Actions::CreateService.call(result.to_h.merge(user_id: current_user.id))
          render json: ActionSerializer.new.serialize(action)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
