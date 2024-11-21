# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      name: 'movie name',
      status: 'watched',
      rating: 'interesting'
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
      result = contract.call(params.except(:name))
      expect(result.errors[:name]).to include('is missing')
    end
  end
end
