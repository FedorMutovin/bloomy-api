# frozen_string_literal: true

module Api
  module V1
    class GoalsController < BaseController
      before_action :goal, only: %i[show]
      def index
        goals = GoalRepository.by_user_id(user_id: current_user.id)
        render json: Panko::ArraySerializer.new(goals, each_serializer: GoalSerializer, except: [:tasks]).to_json
      end

      def show
        render json: GoalSerializer.new.serialize_to_json(goal)
      end

      def create
        goal = Goals::Create.new(params: goals_params, user_id: current_user.id, trigger_params:).call
        render json: GoalSerializer.new(except: [:tasks]).serialize(goal)
      end

      private

      def goal
        @goal ||= GoalRepository.by_id(id: params[:id])
      end

      def goals_params
        params.require(:goal).permit(:name, :description, :priority, :initiated_at,
                                     tasks_attributes: %i[name description priority initiated_at])
      end

      def trigger_params
        params.require(:goal).fetch(:trigger, {}).permit(:id, :event_type, :name)
      end
    end
  end
end
