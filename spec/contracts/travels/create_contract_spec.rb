# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Travels::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      destination: 'travel destination',
      description: 'travel description',
      start_at: DateTime.current - 1.hour,
      end_at: DateTime.current + 10.hours,
      initiated_at: DateTime.current
    }
  end

  let(:trigger_params) do
    {
      trigger: {
        id: 'trigger_id',
        event_type: 'some_event_type',
        name: 'Trigger name'
      }
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(params.merge(trigger_params))
      expect(result).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if initiated_at is missing' do
      result = contract.call(params.except(:initiated_at))
      expect(result.errors[:initiated_at]).to include('is missing')
    end

    context 'when trigger id is missing' do
      let(:trigger_params) do
        {
          trigger: {
            event_type: 'Goal',
            name: 'Trigger Event'
          }
        }
      end

      it 'fails' do
        result = contract.call(params.merge(trigger_params))
        expect(result.errors[:trigger][:id]).to include('is missing')
      end
    end

    context 'when trigger event_type is missing' do
      let(:trigger_params) do
        {
          trigger: {
            id: 'b5192329-c1c5-4202-a715-5536785fbf59',
            name: 'Trigger Event'
          }
        }
      end

      it 'fails' do
        result = contract.call(params.merge(trigger_params))
        expect(result.errors[:trigger][:event_type]).to include('is missing')
      end
    end

    context 'when trigger name is missing' do
      let(:trigger_params) do
        {
          trigger: {
            id: 'b5192329-c1c5-4202-a715-5536785fbf59',
            event_type: 'Goal'
          }
        }
      end

      it 'fails' do
        result = contract.call(params.merge(trigger_params))
        expect(result.errors[:trigger][:name]).to include('is missing')
      end
    end
  end

  context 'when checking started_at rules' do
    it 'fails if started_at is in the future' do
      result = contract.call(params.merge(end_at: DateTime.current - 10.hours))
      expect(result.errors[:end_at]).to include(I18n.t('errors.events.trackable.end_date_time_in_future'))
    end
  end
end
