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

  context 'when checking for required fields' do
    it 'fails if name is missing' do
      result = contract.call(valid_params.except(:name))
      expect(result.errors[:name]).to include('is missing')
    end

    it 'fails if priority is missing' do
      result = contract.call(valid_params.except(:priority))
      expect(result.errors[:priority]).to include('is missing')
    end

    it 'fails if initiated_at is missing' do
      result = contract.call(valid_params.except(:initiated_at))
      expect(result.errors[:initiated_at]).to include('is missing')
    end
  end
end
