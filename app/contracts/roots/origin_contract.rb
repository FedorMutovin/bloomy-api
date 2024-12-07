# frozen_string_literal: true

module Roots
  class OriginContract < ApplicationContract
    params do
      required(:id).filled(:string)
      required(:event_type).filled(:string)
    end
  end
end
