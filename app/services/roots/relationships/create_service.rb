# frozen_string_literal: true

module Roots
  module Relationships
    class CreateService < ApplicationService
      param :params, default: proc { {} }, reader: :private

      def call
        validation_result = validate
        create_relationship!(validation_result.to_h) if validation_result.success?
      end

      private

      def validate
        validation_contract.call(params)
      end

      def create_relationship!(params)
        Roots::RelationshipRepository.add(
          triggerable_id: params[:triggerable_id],
          triggerable_type: params[:triggerable_type],
          impactable_id: params[:impactable_id],
          impactable_type: params[:impactable_type],
          user_id: params[:user_id]
        )
      end

      def validation_contract
        Roots::Relationships::CreateContract.new
      end
    end
  end
end
