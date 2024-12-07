# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::CreateContract do
  subject(:contract) { described_class.new }

  let(:valid_params) do
    {
      name: 'Task Name',
      priority: 1,
      initiated_at: DateTime.current,
      status: Status::IN_PROGRESS,
      started_at: DateTime.current - 1.hour
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(valid_params)
      expect(result).to be_success
    end
  end

  context 'when rule(:started_at)' do
    it 'fails if started_at is in the future' do
      result = contract.call(valid_params.merge(started_at: DateTime.current + 1.hour))
      expect(result.errors[:started_at]).to include(I18n.t('errors.events.trackable.start_date_time_in_future'))
    end

    it 'requires started_at when status is set to IN_PROGRESS' do
      result = contract.call(valid_params.except(:started_at))
      expect(result.errors[:started_at]).to include(
        I18n.t('errors.events.trackable.start_date_required_for_in_progress',
               status: Status::IN_PROGRESS)
      )
    end
  end

  context 'when rule(:schedule)' do
    it 'requires schedule key when status is set to SCHEDULED' do
      result = contract.call(valid_params.except(:started_at).merge(status: Status::SCHEDULED))
      expect(result.errors[:schedule]).to include(I18n.t('errors.events.trackable.schedule_required_for_scheduled',
                                                         status: Status::SCHEDULED))
    end

    it 'is valid when status is SCHEDULED and schedule is present' do
      result = contract
               .call(valid_params
                         .except(:started_at)
                         .merge(
                           status: Status::SCHEDULED,
                           schedule: { scheduled_at: DateTime.current + 1.day }
                         ))
      expect(result).to be_success
    end
  end

  context 'when rule(:started_at, :schedule)' do
    it 'fails if both started_at and schedule are present' do
      result = contract.call(valid_params.merge(status: Status::SCHEDULED,
                                                schedule: { scheduled_at: DateTime.current + 1.day }))
      expect(result.errors[:started_at]).to include(
        I18n.t('errors.events.trackable.both_started_at_and_schedule_present')
      )
    end
  end

  context 'when rule(:status)' do
    it 'fails if status is SCHEDULED but schedule key is missing' do
      result = contract.call(valid_params.except(:started_at).merge(status: Status::SCHEDULED))
      expect(result.errors[:schedule]).to include(I18n.t('errors.events.trackable.schedule_required_for_scheduled',
                                                         status: Status::SCHEDULED))
    end

    it 'fails if status is not IN_PROGRESS when started_at is present' do
      result = contract.call(valid_params.merge(status: Status::SCHEDULED))
      expect(result.errors[:status]).to include(I18n.t('errors.events.trackable.status_must_be_in_progress',
                                                       status_in_progress: Status::IN_PROGRESS))
    end
  end

  context 'when rule(:deadline_at)' do
    it 'fails if deadline_at is not in the future' do
      result = contract.call(valid_params.merge(deadline_at: DateTime.current - 1.hour))
      expect(result.errors[:deadline_at]).to include(
        I18n.t('errors.events.trackable.deadline_at_must_be_in_the_future')
      )
    end
  end

  context 'when rule(:deadline_at, :schedule)' do
    it 'fails if deadline_at is not in the future' do
      result = contract.call(valid_params.merge(deadline_at: DateTime.current - 1.hour))
      expect(result.errors[:deadline_at]).to include(
        I18n.t('errors.events.trackable.deadline_at_must_be_in_the_future')
      )
    end

    it 'fails if deadline_at is earlier than schedule.scheduled_at' do
      result = contract.call(
        valid_params.merge(
          deadline_at: DateTime.current + 1.day,
          schedule: { scheduled_at: DateTime.current + 2.days }
        )
      )
      expect(result.errors[:deadline_at])
        .to include(I18n.t('errors.events.trackable.deadline_at_must_be_more_than_scheduled_at'))
    end

    it 'is valid if deadline_at is later than schedule.scheduled_at' do
      result = contract.call(
        valid_params.merge(
          deadline_at: DateTime.current + 3.days,
          status: Status::SCHEDULED,
          schedule: { scheduled_at: DateTime.current + 2.days }
        ).except(:started_at)
      )
      expect(result).to be_success
    end
  end
end
