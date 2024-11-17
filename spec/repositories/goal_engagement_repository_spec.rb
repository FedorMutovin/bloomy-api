# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalEngagementRepository do
  describe '.add(params)' do
    let(:goal) { create(:goal) }
    let(:params) do
      { value: 1, goal_id: goal.id }
    end

    it 'creates a goal engagement' do
      expect { described_class.add(**params) }.to change(GoalEngagement, :count).by(1)
    end
  end

  describe '.by_goal_id(goal_id)' do
    let(:goal) { create(:goal) }
    let!(:goal_engagement) { create(:goal_engagement, goal:) }

    it 'finds a goal engagement for the specific goal' do
      expect(described_class.by_goal_id(goal.id)).to eq(goal_engagement)
    end
  end

  describe '.update(id, params)' do
    let(:goal_engagement) { create(:goal_engagement) }
    let(:params) do
      { value: 2 }
    end

    it 'updates a goal engagement' do
      expect(goal_engagement.value).not_to eq(2)
      described_class.update(goal_engagement.id, **params)
      expect(goal_engagement.reload.value).to eq(2)
    end
  end
end
