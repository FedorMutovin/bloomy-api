# frozen_string_literal: true

module Roots
  class UniteContract < ApplicationContract
    params do
      required(:reason).filled(:string)
      required(:source).hash(Roots::OriginContract.schema)
      required(:target).hash(Roots::OriginContract.schema)
    end

    rule(:source, :target) do
      if values[:source][:event_type] != values[:target][:event_type]
        base.failure(I18n.t('errors.roots.unite.rule_type_can_not_be_different'))
      elsif values[:source][:id] == values[:target][:id]
        base.failure(I18n.t('errors.roots.unite.root_can_not_be_same'))
      end
    end
  end
end
