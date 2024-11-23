# frozen_string_literal: true

module Goals
  class CreateContract < ApplicationContract
    params(Events::CreateContract.schema) do
      optional(:started_at).filled(:date_time)
      optional(:deadline_at).filled(:date_time)
      optional(:status).filled(:string, included_in?: Statuses::Goal::ALLOWED_FOR_CREATE)
      optional(:engagement_changes).hash do
        required(:value).filled(:integer)
      end
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

    rule(:engagement_changes) do
      if value && value[:value]
        if value[:value] < EngagementChangeable::MIN_CHANGE_VALUE
          key.failure(
            I18n.t('errors.events.engagementable.must_be_not_less_than',
                   min_value: EngagementChangeable::MIN_CHANGE_VALUE)
          )
        end

        if value[:value] > EngagementChangeable::MAX_CHANGE_VALUE
          key.failure(
            I18n.t('errors.events.engagementable.must_be_no_more_than',
                   max_value: EngagementChangeable::MAX_CHANGE_VALUE)
          )
        end
      end
    end

    rule(:deadline_at) do
      if key? && value < DateTime.current
        key.failure(I18n.t('errors.events.trackable.deadline_at_must_be_in_the_future'))
      end
    end
  end
end
