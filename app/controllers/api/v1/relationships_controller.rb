# frozen_string_literal: true

module Api
  module V1
    class RelationshipsController < BaseController
      def index
        decisions = RetaRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(decisions, each_serializer: DecisionSerializer).to_json
      end
    end
  end
end
