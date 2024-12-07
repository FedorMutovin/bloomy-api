# frozen_string_literal: true

module Api
  module V1
    class ThoughtsController < BaseController
      def index
        tasks = ThoughtRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(tasks, each_serializer: ThoughtSerializer).to_json
      end

      def create
        result = validate_params(contract: Thoughts::CreateContract.new, params: params[:thought])

        if result.success?
          task = Thoughts::CreateService.call(result.to_h.merge(user_id: current_user.id))
          render json: ThoughtSerializer.new.serialize(task)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
