# frozen_string_literal: true

module Travels
  class CreateContract < ApplicationContract
    params do
      optional(:description).filled(:string)
      required(:destination).filled(:string)
      required(:initiated_at).filled(:date_time)
      required(:start_at).filled(:date_time)
      required(:end_at).filled(:date_time)
      optional(:origin_root).hash(Roots::OriginContract.schema)
    end

    rule(:end_at) do
      if key? && values[:start_at].present? && values[:start_at] >= value
        key.failure(I18n.t('errors.events.trackable.end_date_time_before_start_date_time'))
      end
    end
  end
end
