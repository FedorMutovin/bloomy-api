# frozen_string_literal: true

module Wishes
  class CreateContract < ApplicationContract
    params(Roots::CreateContract.schema) do
      required(:priority).value(:integer, gteq?: Root::MAX_PRIORITY, lteq?: Root::MIN_PRIORITY)
    end
  end
end
