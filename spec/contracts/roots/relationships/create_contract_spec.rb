# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::Relationships::CreateContract do
  subject(:contract) { described_class.new }

  let(:triggerable_id) { 'id-1' }
  let(:triggerable_type) { 'Goal' }
  let(:impactable_id) { 'id-2' }
  let(:impactable_type) { 'Task' }

  let(:params) do
    {
      triggerable_id:,
      triggerable_type:,
      impactable_id:,
      impactable_type:,
      user_id: 'id-3'
    }
  end

  context 'with valid parameters' do
    it 'is valid when all required fields are present and conditions are met' do
      result = contract.call(params)
      expect(result).to be_success
    end
  end

  context 'when checking for required fields' do
    it 'fails if triggerable_id is missing' do
      result = contract.call(params.except(:triggerable_id))
      expect(result.errors[:triggerable_id]).to include('is missing')
    end

    it 'fails if triggerable_type is missing' do
      result = contract.call(params.except(:triggerable_type))
      expect(result.errors[:triggerable_type]).to include('is missing')
    end

    it 'fails if impactable_id is missing' do
      result = contract.call(params.except(:impactable_id))
      expect(result.errors[:impactable_id]).to include('is missing')
    end

    it 'fails if impactable_type is missing' do
      result = contract.call(params.except(:impactable_type))
      expect(result.errors[:impactable_type]).to include('is missing')
    end

    it 'fails if user_id is missing' do
      result = contract.call(params.except(:user_id))
      expect(result.errors[:user_id]).to include('is missing')
    end
  end

  context 'when rule(:triggerable_type, :impactable_type)' do
    context 'when triggerable and impactable are the same root' do
      let(:triggerable_id) { 'id-1' }
      let(:triggerable_type) { 'Goal' }
      let(:impactable_id) { 'id-1' }
      let(:impactable_type) { 'Goal' }

      it 'fails' do
        result = contract.call(params)
        expect(result.errors.filter(:base?).map(&:to_s))
          .to include(I18n.t('errors.roots.create.trigger_and_impact_can_not_be_same'))
      end
    end
  end
end
