# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Actions::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'action',
      description: 'action description',
      initiated_at: DateTime.current
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a action' do
      it 'creates a new action with the specified attributes' do
        allow(ActionRepository).to receive(:add)
        service_call
        expect(ActionRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:action) { build_stubbed(:action, user:, name: 'action', description: 'action description') }

      it 'adds an event relationship if trigger is present' do
        allow(ActionRepository).to receive(:add).and_return(action)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: action.id,
          impactable_type: action.class.name
        )
      end
    end
  end
end
