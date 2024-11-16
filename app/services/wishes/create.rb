# frozen_string_literal: true

module Wishes
  class Create < ApplicationService
    param :params, reader: :private

    def call
      ActiveRecord::Base.transaction do
        @wish = create_wish!
        add_event_relationship if params[:trigger].present?
      end

      @wish
    end

    private

    def create_wish!
      WishRepository.add(
        user_id: params[:user_id],
        name: params[:name],
        description: params[:description],
        priority: params[:priority],
        initiated_at: params[:initiated_at]
      )
    end

    def add_event_relationship
      Events::RelationshipRepository.add(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: @wish.id,
        impactable_type: @wish.class.name
      )
    end
  end
end
