# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      name: 'Event Name',
      priority: 1,
      initiated_at: DateTime.current
    }
  end

  let(:trigger_params) do
    {
      trigger: {
        id: 'b5192329-c1c5-4202-a715-5536785fbf59',
        event_type: 'Goal',
        name: 'Trigger Event'
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
    it 'fails if name is missing' do
      result = contract.call(params.except(:name))
      expect(result.errors[:name]).to include('is missing')
    end

    it 'fails if priority is missing' do
      result = contract.call(params.except(:priority))
      expect(result.errors[:priority]).to include('is missing')
    end

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
end
