# frozen_string_literal: true

module Api
  module V1
    class HobbiesController < BaseController
      def index
        hobbies = HobbyRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(hobbies, each_serializer: HobbySerializer).to_json
      end

      def create
        result = validate_params(contract: Hobbies::CreateContract.new, params: params[:hobby])

        if result.success?
          hobby = Hobbies::CreateService.call(result.to_h.merge(user_id: current_user.id))
          render json: HobbySerializer.new.serialize(hobby)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
