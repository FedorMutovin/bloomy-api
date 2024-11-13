# frozen_string_literal: true

module Actions
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:description).filled(:string)
      required(:initiated_at).filled(:date_time)
      optional(:trigger).hash do
        required(:id).filled(:string)
        required(:event_type).filled(:string)
        required(:name).filled(:string)
      end
    end
  end
end
