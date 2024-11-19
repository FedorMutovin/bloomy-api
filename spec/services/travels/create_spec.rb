# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Travels::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      destination: 'travel destination',
      description: 'travel description',
      initiated_at: DateTime.current,
      start_at: DateTime.current - 1.hour,
      end_at: DateTime.current + 10.hours
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a travel' do
      it 'creates a new travel with the specified attributes' do
        allow(TravelRepository).to receive(:add)
        service_call
        expect(TravelRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:travel) do
        build_stubbed(:travel, user:, destination: 'travel destination', description: 'travel description')
      end

      it 'adds an event relationship if trigger is present' do
        allow(TravelRepository).to receive(:add).and_return(travel)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: travel.id,
          impactable_type: travel.class.name
        )
      end
    end
  end
end
