# frozen_string_literal: true

module Api
  module V1
    class MoviesController < BaseController
      def index
        movies = MovieRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(movies, each_serializer: MovieSerializer).to_json
      end

      def create
        result = validate_params(contract: Movies::CreateContract.new, params: params[:movie])

        if result.success?
          movie = Movies::CreateService.call(result.to_h.merge(user_id: current_user.id))
          render json: MovieSerializer.new.serialize(movie)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
