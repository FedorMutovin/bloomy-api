# frozen_string_literal: true

module Api
  module V1
    class RootsController < BaseController
      def unite
        result = validate_params(contract: Roots::UniteContract.new, params: params[:roots_unite])

        if result.success?
          roots_unite = Roots::UniteService.call(result.to_h.merge(user_id: current_user.id))
          render json: Roots::UniteSerializer.new.serialize(roots_unite)
        else
          render json: { errors: result.errors.to_h }, status: :unprocessable_entity
        end
      end
    end
  end
end
