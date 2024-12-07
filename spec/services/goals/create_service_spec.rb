# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goals::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { GoalRepository }
    let(:record_factory) { :goal }
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

    context 'when adding engagement changes' do
      let(:engagement_changes) do
        { engagement_changes: { value: 1 } }
      end
      let(:params) { attributes.merge(engagement_changes) }
      let(:goal) { build_stubbed(record_factory, user:, name: 'goal', description: 'goal description') }

      it 'adds an engagement change if engagement_changes is present' do
        allow(repository_class).to receive(:add).and_return(goal)
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
