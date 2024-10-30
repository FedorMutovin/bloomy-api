# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def current
        render json: UserSerializer.new.serialize_to_json(current_user)
      end
    end
  end
end
