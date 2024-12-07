# frozen_string_literal: true

module Roots
  class CreateService < ApplicationService
    param :params, default: proc { {} }, reader: :private

    def call
      root = create_root!
      after_create(root)

      root
    end

    private

    def create_root!
      raise NotImplementedError
    end

    def after_create(root)
      create_root_relationship(root) if params[:trigger].present?
    end

    def create_root_relationship(root)
      Roots::Relationships::CreateService.call(
        triggerable_id: params[:trigger][:id],
        triggerable_type: params[:trigger][:event_type],
        impactable_id: root.id,
        impactable_type: root.class.name,
        user_id: root.user_id
      )
    end
  end
end
