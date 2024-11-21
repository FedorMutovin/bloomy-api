# frozen_string_literal: true

module Decisions
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @decision = create_decision!
        add_event_relationship if params[:trigger].present?
      end

      @decision
    end

    private

    def create_decision!
      DecisionRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        name: params[:name],
        initiated_at: params[:initiated_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @decision.id,
        impactable_type: @decision.class.name
      )
    end
  end
end
