# frozen_string_literal: true

module Events
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:description).filled(:string)
      required(:priority).value(:integer, gteq?: Event::MAX_PRIORITY, lteq?: Event::MIN_PRIORITY)
      required(:initiated_at).filled(:date_time)
      optional(:trigger).hash do
        required(:id).filled(:string)
        required(:event_type).filled(:string)
        required(:name).filled(:string)
      end
    end
  end
end
