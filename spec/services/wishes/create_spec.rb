# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wishes::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'wish',
      description: 'wish description',
      priority: 1,
      initiated_at: DateTime.current
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a wish' do
      it 'creates a new wish with the specified attributes' do
        allow(WishRepository).to receive(:add)
        service_call
        expect(WishRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'goal-id', event_type: 'Goal' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:wish) { build_stubbed(:wish, user:, name: 'wish', description: 'wish description') }

      it 'adds an event relationship if trigger is present' do
        allow(WishRepository).to receive(:add).and_return(wish)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: wish.id,
          impactable_type: wish.class.name
        )
      end
    end
  end
end
