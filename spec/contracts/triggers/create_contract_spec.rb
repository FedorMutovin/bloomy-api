# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Triggers::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      id: 'trigger_id',
      event_type: 'some_event_type',
      name: 'Trigger name'
    }
  end

  context 'when checking for required fields' do
    context 'when trigger id is missing' do
      let(:params) do
        {
          event_type: 'Event name',
          name: 'Trigger Event'
        }
      end

      it 'fails' do
        result = contract.call(params.except(:id))
        expect(result.errors[:id]).to include('is missing')
      end
    end

    context 'when trigger event_type is missing' do
      let(:params) do
        {
          id: 'b5192329-c1c5-4202-a715-5536785fbf59',
          name: 'Trigger Event'
        }
      end

      it 'fails' do
        result = contract.call(params.except(:event_type))
        expect(result.errors[:event_type]).to include('is missing')
      end
    end

    context 'when trigger name is missing' do
      let(:params) do
        {
          id: 'b5192329-c1c5-4202-a715-5536785fbf59',
          event_type: 'Goal'
        }
      end

      it 'fails' do
        result = contract.call(params.except(:name))
        expect(result.errors[:name]).to include('is missing')
      end
    end
  end
end
