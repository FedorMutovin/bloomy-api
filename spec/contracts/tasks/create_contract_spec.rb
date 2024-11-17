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
      started_at: DateTime.current - 1.hour,
      trigger: {
        id: 'b5192329-c1c5-4202-a715-5536785fbf59',
        event_type: 'Goal',
        name: 'Trigger Event'
      }
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(valid_params)
      expect(result).to be_success
    end
  end

  context 'when checking started_at rules' do
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

  context 'when checking schedule rules' do
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

  context 'when checking conflicts between started_at and schedule' do
    it 'fails if both started_at and schedule are present' do
      result = contract.call(valid_params.merge(status: Status::SCHEDULED,
                                                schedule: { scheduled_at: DateTime.current + 1.day }))
      expect(result.errors[:started_at]).to include(
        I18n.t('errors.events.trackable.both_started_at_and_schedule_present')
      )
    end
  end

  context 'when checking status dependencies' do
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

  context 'when checking engagement_changes rules' do
    it 'fails if engagement_changes.value is less than the minimum' do
      result = contract.call(valid_params.merge(
                               engagement_changes: { value: TaskEngagementChange::MIN_CHANGE_VALUE - 1 }
                             ))
      expect(result.errors[:engagement_changes]).to include(
        I18n.t('errors.events.engagementable.must_be_not_less_than',
               min_value: TaskEngagementChange::MIN_CHANGE_VALUE)
      )
    end

    it 'fails if engagement_changes.value is more than the maximum' do
      result = contract.call(valid_params.merge(engagement_changes: {
                                                  value: TaskEngagementChange::MAX_CHANGE_VALUE + 1
                                                }))
      expect(result.errors[:engagement_changes]).to include(
        I18n.t('errors.events.engagementable.must_be_no_more_than',
               max_value: TaskEngagementChange::MAX_CHANGE_VALUE)
      )
    end

    it 'is valid if engagement_changes.value is within the allowed range' do
      result = contract.call(
        valid_params
          .merge(
            engagement_changes: { value: TaskEngagementChange::MAX_CHANGE_VALUE }
          )
      )
      expect(result).to be_success
    end
  end
end
