# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::Relationships::CreateService, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:params) do
    {
      triggerable_id: 'id-1',
      triggerable_type: 'Goal',
      impactable_id: 'id-2',
      impactable_type: 'Task',
      user_id: user.id
    }
  end

  describe '#call' do
    context 'when creating roots relationship' do
      let(:validation_result) { instance_double(Dry::Validation::Result, success?: true, to_h: params) }
      let(:contract_instance) { instance_double(Roots::Relationships::CreateContract, call: validation_result) }

      before do
        allow(Roots::Relationships::CreateContract).to receive(:new).and_return(contract_instance)
        allow(Roots::RelationshipRepository).to receive(:add)
      end

      it 'validates params using the contract' do
        service_call
        expect(contract_instance).to have_received(:call).with(params)
      end

      it 'creates root relationships with specified params' do
        service_call
        expect(Roots::RelationshipRepository).to have_received(:add).with(params)
      end
    end

    context 'when validation fails' do
      let(:validation_result) { instance_double(Dry::Validation::Result, success?: false, to_h: {}) }
      let(:contract_instance) { instance_double(Roots::Relationships::CreateContract, call: validation_result) }

      before do
        allow(Roots::Relationships::CreateContract).to receive(:new).and_return(contract_instance)
        allow(Roots::RelationshipRepository).to receive(:add)
      end

      it 'does not create a relationship' do
        service_call
        expect(Roots::RelationshipRepository).not_to have_received(:add)
      end
    end
  end
end
