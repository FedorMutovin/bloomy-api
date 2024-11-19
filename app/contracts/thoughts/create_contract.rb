# frozen_string_literal: true

module Thoughts
  class CreateContract < ApplicationContract
    params do
      required(:description).filled(:string)
      required(:initiated_at).filled(:date_time)
      optional(:trigger).hash do
        required(:id).filled(:string)
        required(:event_type).filled(:string)
        required(:name).filled(:string)
      end
    end
  end
end
