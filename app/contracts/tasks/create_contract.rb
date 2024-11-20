# frozen_string_literal: true

module Tasks
  class CreateContract < ApplicationContract
    params(Events::CreateContract.schema) do
      optional(:started_at).filled(:date_time)
      required(:status).filled(:string, included_in?: Statuses::Task::ALLOWED_FOR_CREATE)
      optional(:deadline_at).filled(:date_time)
      optional(:engagement_changes).hash(EngagementChanges::CreateContract.schema)
      optional(:schedule).hash do
        required(:scheduled_at).filled(:date_time)
      end
    end

    rule(:started_at) do
      key.failure(I18n.t('errors.events.trackable.start_date_time_in_future')) if key? && value > DateTime.current

      if !key? && values[:status] == Status::IN_PROGRESS && !key?(:schedule)
        key.failure(I18n.t('errors.events.trackable.start_date_required_for_in_progress', status: Status::IN_PROGRESS))
      end
    end

    rule(:schedule) do
      if !key? && values[:status] == Status::SCHEDULED
        key.failure(I18n.t('errors.events.trackable.schedule_required_for_scheduled', status: Status::SCHEDULED))
      end
    end

    rule(:status) do
      if !key?(:schedule) && (values[:started_at] && values[:status] != Status::IN_PROGRESS)
        key.failure(I18n.t('errors.events.trackable.status_must_be_in_progress',
                           status_in_progress: Status::IN_PROGRESS))
      end

      if key?(:schedule) && values[:status] != Status::SCHEDULED
        key.failure(I18n.t('errors.events.trackable.status_must_be_scheduled', status_scheduled: Status::SCHEDULED))
      end
    end

    rule(:started_at, :schedule) do
      if values[:started_at] && values[:schedule]
        key.failure(I18n.t('errors.events.trackable.both_started_at_and_schedule_present'))
      end
    end

    rule(:deadline_at) do
      if key? && value < DateTime.current
        key.failure(I18n.t('errors.events.trackable.deadline_at_must_be_in_the_future'))
      end
    end

    rule(:deadline_at, :schedule) do
      if values[:deadline_at] && values[:schedule] && values[:schedule][:scheduled_at] > (values[:deadline_at])
        key(:deadline_at).failure(
          I18n.t('errors.events.trackable.deadline_at_must_be_more_than_scheduled_at')
        )
      end
    end
  end
end
