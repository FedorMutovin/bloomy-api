# frozen_string_literal: true

module Api
  module V1
    class TravelsController < BaseController
      def index
        travels = TravelRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(travels, each_serializer: TravelSerializer).to_json
      end

      def create
        result = validate_params(contract: Travels::CreateContract.new, params: params[:travel])

        if result.success?
          travel = Travels::CreateService.call(result.to_h.merge(user_id: current_user.id))
          render json: TravelSerializer.new.serialize(travel)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
