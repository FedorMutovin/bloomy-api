# frozen_string_literal: true

module Events
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:description).filled(:string)
      required(:priority).value(:integer, gteq?: Event::MAX_PRIORITY, lteq?: Event::MIN_PRIORITY)
      required(:initiated_at).filled(:date_time)
      optional(:trigger).hash(Triggers::CreateContract.schema)
    end
  end
end
