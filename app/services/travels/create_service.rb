# frozen_string_literal: true

module Travels
  class CreateService < Roots::CreateService
    private

    def create_root!
      TravelRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        destination: params[:destination],
        initiated_at: params[:initiated_at],
        start_at: params[:start_at],
        end_at: params[:end_at]
      )
    end
  end
end
