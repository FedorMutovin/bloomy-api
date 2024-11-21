# frozen_string_literal: true

module Actions
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:description).filled(:string)
      required(:initiated_at).filled(:date_time)
      optional(:trigger).hash(Triggers::CreateContract.schema)
    end
  end
end
