# frozen_string_literal: true

module Wishes
  class CreateService < Roots::CreateService
    private

    def create_root!
      WishRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        description: params[:description],
        priority: params[:priority],
        initiated_at: params[:initiated_at]
      )
    end
  end
end
