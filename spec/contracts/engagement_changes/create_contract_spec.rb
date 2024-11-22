# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EngagementChanges::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      value: 0
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      expect(contract.call(params)).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if value is missing' do
      result = contract.call(params.except(:value))
      expect(result.errors[:value]).to include('is missing')
    end

    it 'fails if value is greater then EngagementChangeable::MAX_CHANGE_VALUE' do
      result = contract.call(params.merge(value: EngagementChangeable::MAX_CHANGE_VALUE + 1))
      expect(result.errors[:value])
        .to include("must be less than or equal to #{EngagementChangeable::MAX_CHANGE_VALUE}")
    end

    it 'fails if value is less then EngagementChangeable::MIN_CHANGE_VALUE' do
      result = contract.call(params.merge(value: EngagementChangeable::MIN_CHANGE_VALUE - 1))
      expect(result.errors[:value])
        .to include("must be greater than or equal to #{EngagementChangeable::MIN_CHANGE_VALUE}")
    end
  end
end
