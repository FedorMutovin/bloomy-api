# frozen_string_literal: true

module Movies
  class CreateContract < ApplicationContract
    params do
      required(:name).filled(:string)
      required(:status).filled(:string, included_in?: Statuses::Movie::ALLOWED_FOR_CREATE)
      required(:initiated_at).filled(:date_time)
      optional(:rating).filled(:string, included_in?: Movie::ALLOWED_RATINGS)
      optional(:completed_at).filled(:date_time)
      optional(:origin_root).hash(Roots::OriginContract.schema)
    end

    rule(:completed_at) do
      if values[:status] == Statuses::Movie::WATCHED && values[:completed_at].blank?
        key.failure(I18n.t('errors.events.trackable.completed_at_required'))
      end
    end
  end
end
