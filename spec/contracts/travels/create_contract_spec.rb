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

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(params)
      expect(result).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if initiated_at is missing' do
      result = contract.call(params.except(:initiated_at))
      expect(result.errors[:initiated_at]).to include('is missing')
    end

    it 'fails if start_at is missing' do
      result = contract.call(params.except(:start_at))
      expect(result.errors[:start_at]).to include('is missing')
    end

    it 'fails if end_at is missing' do
      result = contract.call(params.except(:end_at))
      expect(result.errors[:end_at]).to include('is missing')
    end

    it 'fails if destination is missing' do
      result = contract.call(params.except(:destination))
      expect(result.errors[:destination]).to include('is missing')
    end
  end

  context 'when checking started_at rules' do
    it 'fails if started_at is in the future' do
      result = contract.call(params.merge(end_at: DateTime.current - 10.hours))
      expect(result.errors[:end_at]).to include(I18n.t('errors.events.trackable.end_date_time_before_start_date_time'))
    end
  end
end
