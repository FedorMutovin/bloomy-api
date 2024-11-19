# frozen_string_literal: true

module Thoughts
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @thought = create_thought!
        add_event_relationship if params[:trigger].present?
      end

      @thought
    end

    private

    def create_thought!
      ThoughtRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        initiated_at: params[:initiated_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @thought.id,
        impactable_type: @thought.class.name
      )
    end
  end
end
