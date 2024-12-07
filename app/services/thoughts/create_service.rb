# frozen_string_literal: true

module Thoughts
  class CreateService < Roots::CreateService
    private

    def create_root!
      ThoughtRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        initiated_at: params[:initiated_at]
      )
    end
  end
end
