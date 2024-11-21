# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::CreateContract do
  subject(:contract) { described_class.new }

  let(:params) do
    {
      name: 'movie name',
      status: 'watched',
      rating: 'interesting',
      completed_at: '2024-11-11T17:03:32Z'
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

    it 'fails if status is missing' do
      result = contract.call(params.except(:status))
      expect(result.errors[:status]).to include('is missing')
    end
  end

  context 'when checking completed_at rules' do
    it 'fails if completed_at is blank when status is watched' do
      result = contract.call(params.merge(status: 'watched', completed_at: nil))
      expect(result.errors[:completed_at]).to include(I18n.t('errors.events.trackable.completed_at_required_when_watched'))
    end
  end
end
