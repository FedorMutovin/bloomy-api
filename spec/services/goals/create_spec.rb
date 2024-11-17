# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goals::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'goal',
      description: 'goal description',
      priority: 1,
      initiated_at: DateTime.current,
      started_at: DateTime.current - 1.hour,
      status: Status::IN_PROGRESS
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a goal' do
      it 'creates a new goal with the specified attributes' do
        allow(GoalRepository).to receive(:add)
        service_call
        expect(GoalRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:goal) { build_stubbed(:goal, user:, name: 'goal', description: 'goal description') }

      it 'adds an event relationship if trigger is present' do
        allow(GoalRepository).to receive(:add).and_return(goal)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: goal.id,
          impactable_type: goal.class.name
        )
      end
    end

    context 'when adding engagement changes' do
      let(:engagement_changes) do
        { engagement_changes: { value: 1 } }
      end
      let(:params) { attributes.merge(engagement_changes) }
      let(:goal) { build_stubbed(:goal, user:, name: 'goal', description: 'goal description') }

      it 'adds an engagement change if engagement_changes is present' do
        allow(GoalRepository).to receive(:add).and_return(goal)
        allow(GoalEngagementRepository).to receive(:add)

        service_call

        expect(GoalEngagementRepository).to have_received(:add).with(
          goal_id: goal.id,
          value: params[:engagement_changes][:value]
        )
      end
    end
  end
end
