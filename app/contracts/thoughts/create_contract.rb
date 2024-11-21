# frozen_string_literal: true

module Thoughts
  class CreateContract < ApplicationContract
    params do
      required(:description).filled(:string)
      required(:initiated_at).filled(:date_time)
      optional(:trigger).hash(Triggers::CreateContract.schema)
    end
  end
end
