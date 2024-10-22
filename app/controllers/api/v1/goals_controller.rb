# frozen_string_literal: true

module Api
  module V1
    class GoalsController < BaseController
      before_action :user, only: %i[index]
      def index
        goals = GoalRepository.by_user_id(user_id: user.id)
        render json: Panko::ArraySerializer.new(goals, each_serializer: GoalSerializer).to_json
      end

      private

      def user
        UserRepository.by_id(id: params[:user_id])
      end
    end
  end
end
