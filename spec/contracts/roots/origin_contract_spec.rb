# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::OriginContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      id: 'root_id',
      root_type: 'some_root_type'
    }
  end

  context 'when checking for required fields' do
    context 'when origin root id is missing' do
      let(:params) do
        {
          root_type: 'Root name'
        }
      end

      it 'fails' do
        result = contract.call(params.except(:id))
        expect(result.errors[:id]).to include('is missing')
      end
    end

    context 'when origin root root_type is missing' do
      let(:params) do
        {
          id: 'b5192329-c1c5-4202-a715-5536785fbf59'
        }
      end

      it 'fails' do
        result = contract.call(params.except(:root_type))
        expect(result.errors[:root_type]).to include('is missing')
      end
    end
  end
end
