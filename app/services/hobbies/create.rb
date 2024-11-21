# frozen_string_literal: true

module Hobbies
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @hobby = create_hobby!
        add_event_relationship if params[:trigger].present?
      end

      @hobby
    end

    private

    def create_hobby!
      HobbyRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        skill_level: params[:skill_level],
        engagement_level: params[:engagement_level],
        initiated_at: params[:initiated_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @hobby.id,
        impactable_type: @hobby.class.name
      )
    end
  end
end
