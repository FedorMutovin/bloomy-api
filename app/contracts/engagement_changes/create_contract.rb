# frozen_string_literal: true

module EngagementChanges
  class CreateContract < ApplicationContract
    params do
      required(:value).filled(
        :integer,
        gteq?: EngagementChangeable::MIN_CHANGE_VALUE,
        lteq?: EngagementChangeable::MAX_CHANGE_VALUE
      )
    end
  end
end
