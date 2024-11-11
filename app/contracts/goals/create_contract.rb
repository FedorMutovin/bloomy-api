# frozen_string_literal: true

module Goals
  class CreateContract < ApplicationContract
    params(Events::CreateContract.schema) do
      optional(:started_at).filled(:date_time)
      optional(:status).filled(:string, included_in?: Statuses::Goal::ALLOWED_FOR_CREATE)
    end

    rule(:started_at) do
      key.failure(I18n.t('errors.events.trackable.start_date_time_in_future')) if key? && value > DateTime.current

      if !key? && values[:status] == Status::IN_PROGRESS
        key.failure(I18n.t('errors.events.trackable.start_date_required_for_in_progress', status: Status::IN_PROGRESS))
      end
    end

    rule(:status) do
      if values[:started_at] && values[:status] != Status::IN_PROGRESS
        key.failure(I18n.t('errors.events.trackable.status_must_be_in_progress',
                           status_in_progress: Status::IN_PROGRESS))
      end
    end
  end
end
