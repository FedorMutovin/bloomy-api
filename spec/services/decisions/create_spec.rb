# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Decisions::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'decision name',
      description: 'decision description',
      initiated_at: DateTime.current
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a decision' do
      it 'creates a new decision with the specified attributes' do
        allow(DecisionRepository).to receive(:add)
        service_call
        expect(DecisionRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:decision) do
        build_stubbed(:decision, user:, name: 'decision name', description: 'decision description')
      end

      it 'adds an event relationship if trigger is present' do
        allow(DecisionRepository).to receive(:add).and_return(decision)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: decision.id,
          impactable_type: decision.class.name
        )
      end
    end
  end
end
