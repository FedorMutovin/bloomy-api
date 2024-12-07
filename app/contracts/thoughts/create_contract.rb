# frozen_string_literal: true

module Thoughts
  class CreateContract < ApplicationContract
    params do
      required(:description).filled(:string)
      required(:initiated_at).filled(:date_time)
      optional(:origin_root).hash(Roots::OriginContract.schema)
    end
  end
end
