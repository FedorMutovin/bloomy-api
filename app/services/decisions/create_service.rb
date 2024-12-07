# frozen_string_literal: true

module Decisions
  class CreateService < Roots::CreateService
    private

    def create_root!
      DecisionRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        name: params[:name],
        initiated_at: params[:initiated_at]
      )
    end
  end
end
