# frozen_string_literal: true

module Actions
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @action = create_action!
        add_event_relationship if params[:trigger].present?
      end

      @action
    end

    private

    def create_action!
      ActionRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        description: params[:description],
        initiated_at: params[:initiated_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @action.id,
        impactable_type: @action.class.name
      )
    end
  end
end
