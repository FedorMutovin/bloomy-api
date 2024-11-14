# frozen_string_literal: true

module Api
  module V1
    class GoalsController < BaseController
      before_action :goal, only: %i[show]
      def index
        goals = GoalRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(goals, each_serializer: GoalSerializer).to_json
      end

      def show
        render json: GoalSerializer.new.serialize_to_json(goal)
      end

      def create
        result = validate_params(contract: Goals::CreateContract.new, params: params[:goal])

        if result.success?
          goal = Goals::Create.call(result.to_h.merge(user_id: current_user.id))
          render json: GoalSerializer.new.serialize(goal)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end

      private

      def goal
        @goal ||= GoalRepository.by_id(id: params[:id])
      end
    end
  end
end
