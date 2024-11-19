# frozen_string_literal: true

module Travels
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @travel = create_travel!
        add_event_relationship if params[:trigger].present?
      end

      @travel
    end

    private

    def create_travel!
      TravelRepository.add(
        user_id: params[:user_id],
        description: params[:description],
        destination: params[:destination],
        initiated_at: params[:initiated_at],
        start_at: params[:start_at],
        end_at: params[:end_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @travel.id,
        impactable_type: @travel.class.name
      )
    end
  end
end
