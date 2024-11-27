# frozen_string_literal: true

module Triggers
  class CreateContract < ApplicationContract
    params do
      required(:id).filled(:string)
      required(:event_type).filled(:string)
    end
  end
end
