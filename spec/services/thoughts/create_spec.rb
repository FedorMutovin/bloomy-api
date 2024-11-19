# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thoughts::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      description: 'Thought description',
      initiated_at: DateTime.current
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a thought' do
      it 'creates a new thought with the specified attributes' do
        allow(ThoughtRepository).to receive(:add)
        service_call
        expect(ThoughtRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:thought) do
        build_stubbed(:thought, user:, description: 'travel description')
      end

      it 'adds an event relationship if trigger is present' do
        allow(ThoughtRepository).to receive(:add).and_return(thought)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: thought.id,
          impactable_type: thought.class.name
        )
      end
    end
  end
end
