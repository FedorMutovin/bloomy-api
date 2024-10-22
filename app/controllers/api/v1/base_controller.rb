# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

      private

      def not_found_response
        head :not_found
      end

      def user
        @user ||= UserRepository.by_id(id: params[:user_id])
      end
    end
  end
end
