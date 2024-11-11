# frozen_string_literal: true

module Api
  module V1
    # BaseController serves as the foundation for all API controllers in the V1 namespace.
    # It provides common error handling and validation methods to be used by child controllers.
    # Controllers inheriting from BaseController should implement their specific validation contracts.
    class BaseController < ApplicationController
      # Rescues ActiveRecord::RecordNotFound exceptions and returns a 404 not found response.
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

      private

      # Handles the response for ActiveRecord::RecordNotFound by returning a 404 status with no content.
      #
      # @return [void]
      def not_found_response
        head :not_found
      end

      # Validates incoming parameters using the specified validation contract.
      #
      # @param contract [Dry::Validation::Contract] The contract used to validate parameters.
      # @param params [ActionController::Parameters] The parameters to be validated.
      # @return [Dry::Validation::Result] The result of the validation, containing any errors.
      def validate_params(contract:, params:)
        contract.call(params.to_unsafe_hash)
      end

      def current_user
        # @user ||= UserRepository.by_id(id: params[:user_id])
        # TODO: add session
        User.first
      end
    end
  end
end
