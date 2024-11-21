# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hobbies::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'hobby name',
      skill_level: 1,
      engagement_level: 2,
      initiated_at: DateTime.current
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a hobby' do
      it 'creates a new hobby with the specified attributes' do
        allow(HobbyRepository).to receive(:add)
        service_call
        expect(HobbyRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:hobby) do
        build_stubbed(:hobby, user:, name: 'hobby name', skill_level: 4, engagement_level: 0)
      end

      it 'adds an event relationship if trigger is present' do
        allow(HobbyRepository).to receive(:add).and_return(hobby)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: hobby.id,
          impactable_type: hobby.class.name
        )
      end
    end
  end
end
