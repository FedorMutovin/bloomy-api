# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def current
        render json: UserSerializer.new.serialize_to_json(User.first)
      end
    end
  end
end
