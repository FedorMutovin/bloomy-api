# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Engagements::Goals::Update, type: :service do
  subject(:service_call) { described_class.call(new_value, goal.id) }

  let(:goal) { create(:goal) }
  let(:engagement) { create(:goal_engagement, goal:, value: 0) }
  let(:new_value) { 2 }

  before do
    allow(GoalEngagementRepository).to receive(:by_goal_id).and_return(engagement)
    allow(GoalEngagementChangeRepository).to receive(:add)
    allow(GoalEngagementRepository).to receive(:update)
  end

  describe '#call' do
    it 'finds the engagement by goal_id' do
      service_call
      expect(GoalEngagementRepository).to have_received(:by_goal_id).with(goal.id)
    end

    it 'creates a new engagement change with the correct values' do
      service_call
      expect(GoalEngagementChangeRepository).to have_received(:add).with(
        last_value: engagement.value,
        new_value:,
        engagement: engagement.id
      )
    end

    it 'updates the engagement value' do
      service_call
      expect(GoalEngagementRepository).to have_received(:update).with(
        engagement.id,
        value: new_value
      )
    end
  end
end
