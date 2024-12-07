# frozen_string_literal: true

module Api
  module V1
    class EverydayQuotesController < BaseController
      def index
        events = EverydayQuoteRepository.by_user_id(current_user.id)
        render json: Panko::ArraySerializer.new(events, each_serializer: EverydayQuoteSerializer).to_json
      end
    end
  end
end
