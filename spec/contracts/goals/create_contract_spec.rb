# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goals::CreateContract do
  subject(:contract) { described_class.new }

  let(:valid_params) do
    {
      name: 'Goal Name',
      priority: 1,
      initiated_at: DateTime.current,
      status: Status::IN_PROGRESS,
      started_at: DateTime.current - 1.hour,
      trigger: {
        id: 'b5192329-c1c5-4202-a715-5536785fbf59',
        event_type: 'Wish',
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

  context 'when checking engagement_changes rules' do
    it 'fails if engagement_changes.value is less than the minimum' do
      result = contract.call(valid_params.merge(
                               engagement_changes: { value: EngagementChangeable::MIN_CHANGE_VALUE - 1 }
                             ))
      expect(result.errors[:engagement_changes]).to include(
        I18n.t('errors.events.engagementable.must_be_not_less_than',
               min_value: EngagementChangeable::MIN_CHANGE_VALUE)
      )
    end

    it 'fails if engagement_changes.value is more than the maximum' do
      result = contract.call(valid_params.merge(engagement_changes: {
                                                  value: GoalEngagementChange::MAX_CHANGE_VALUE + 1
                                                }))
      expect(result.errors[:engagement_changes]).to include(
        I18n.t('errors.events.engagementable.must_be_no_more_than',
               max_value: GoalEngagementChange::MAX_CHANGE_VALUE)
      )
    end

    it 'is valid if engagement_changes.value is within the allowed range' do
      result = contract.call(
        valid_params
          .merge(
            engagement_changes: { value: GoalEngagementChange::MAX_CHANGE_VALUE }
          )
      )
      expect(result).to be_success
    end
  end

  context 'when rule(:deadline_at)' do
    it 'fails if deadline_at is not in the future' do
      result = contract.call(valid_params.merge(deadline_at: DateTime.current - 1.hour))
      expect(result.errors[:deadline_at])
        .to include(I18n.t('errors.events.trackable.deadline_at_must_be_in_the_future'))
    end
  end
end
