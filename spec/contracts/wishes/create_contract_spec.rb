# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wishes::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      name: 'Wish Name',
      description: 'Wish Description',
      initiated_at: DateTime.current,
      priority: 3
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(params)
      expect(result).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if name is missing' do
      result = contract.call(params.except(:priority))
      expect(result.errors[:priority]).to include('is missing')
    end
  end
end
