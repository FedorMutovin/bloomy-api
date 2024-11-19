# frozen_string_literal: true

module Travels
  class CreateContract < ApplicationContract
    params do
      optional(:description).filled(:string)
      required(:destination).filled(:string)
      required(:initiated_at).filled(:date_time)
      required(:start_at).filled(:date_time)
      required(:end_at).filled(:date_time)
      optional(:trigger).hash do
        required(:id).filled(:string)
        required(:event_type).filled(:string)
        required(:name).filled(:string)
      end
    end

    rule(:end_at) do
      key.failure(I18n.t('errors.events.trackable.end_date_time_in_future')) if key? && value < values[:start_at]
    end
  end
end
