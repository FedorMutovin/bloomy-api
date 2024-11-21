# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thoughts::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      description: 'Thought description',
      initiated_at: DateTime.current
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(params)
      expect(result).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if description is missing' do
      result = contract.call(params.except(:description))
      expect(result.errors[:description]).to include('is missing')
    end

    it 'fails if initiated_at is missing' do
      result = contract.call(params.except(:initiated_at))
      expect(result.errors[:initiated_at]).to include('is missing')
    end
  end
end
