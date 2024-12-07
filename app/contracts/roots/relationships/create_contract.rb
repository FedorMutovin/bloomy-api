# frozen_string_literal: true

module Roots
  module Relationships
    class CreateContract < ApplicationContract
      params do
        required(:triggerable_id).filled(:string)
        required(:triggerable_type).filled(:string)
        required(:impactable_id).filled(:string)
        required(:impactable_type).filled(:string)
        required(:user_id).filled(:string)
      end

      rule(:triggerable_type, :impactable_type) do
        if values[:triggerable_type] == values[:impactable_type] && values[:triggerable_id] == (values[:impactable_id])
          base.failure(I18n.t('errors.roots.create.trigger_and_impact_can_not_be_same'))
        end
      end
    end
  end
end
