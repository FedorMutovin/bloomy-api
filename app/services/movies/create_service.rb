# frozen_string_literal: true

module Movies
  class CreateService < Roots::CreateService
    private

    def create_root!
      MovieRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        status: params[:status],
        rating: params[:rating],
        completed_at: params[:completed_at]
      )
    end
  end
end
