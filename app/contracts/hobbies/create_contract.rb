# frozen_string_literal: true

module Hobbies
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      required(:initiated_at).filled(:date_time)
      required(:skill_level).value(:integer, gteq?: Hobby::MAX_LEVEL, lteq?: Hobby::MIN_LEVEL)
      required(:engagement_level).value(:integer, gteq?: Hobby::MAX_ENGAGEMENT_LEVEL,
                                                  lteq?: Hobby::MIN_ENGAGEMENT_LEVEL)
      optional(:origin_root).hash(Roots::OriginContract.schema)
    end
  end
end
