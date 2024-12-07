# frozen_string_literal: true

module Api
  module V1
    class DecisionsController < BaseController
      def index
        decisions = DecisionRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(decisions, each_serializer: DecisionSerializer).to_json
      end

      def create
        result = validate_params(contract: Roots::CreateContract.new, params: params[:decision])

        if result.success?
          decision = Decisions::CreateService.call(result.to_h.merge(user_id: current_user.id))
          render json: DecisionSerializer.new.serialize(decision)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
