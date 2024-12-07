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
      create_root_relationship(root) if params[:origin_root].present?
    end

    def create_root_relationship(root)
      Roots::Relationships::CreateService.call(
        triggerable_id: params[:origin_root][:id],
        triggerable_type: params[:origin_root][:root_type],
        impactable_id: root.id,
        impactable_type: root.class.name,
        user_id: root.user_id
      )
    end
  end
end
