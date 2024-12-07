# frozen_string_literal: true

module Hobbies
  class CreateService < Roots::CreateService
    private

    def create_root!
      HobbyRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        skill_level: params[:skill_level],
        engagement_level: params[:engagement_level],
        initiated_at: params[:initiated_at]
      )
    end
  end
end
