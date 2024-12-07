# frozen_string_literal: true

module Actions
  class CreateService < Roots::CreateService
    private

    def create_root!
      ActionRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        description: params[:description],
        initiated_at: params[:initiated_at]
      )
    end
  end
end
