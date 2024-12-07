# frozen_string_literal: true

module Roots
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      optional(:description).filled(:string)
      required(:initiated_at).filled(:date_time)
      optional(:origin_root).hash(Roots::OriginContract.schema)
    end
  end
end
