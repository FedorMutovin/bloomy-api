# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalEngagementChangeRepository do
  describe '.add(params)' do
    let(:goal_engagement) { create(:goal_engagement) }
    let(:params) do
      { last_value: 0, new_value: 2, engagement: goal_engagement, reason: 'reason', initiated_at: DateTime.current }
    end

    it 'creates a goal engagement change' do
      expect { described_class.add(**params) }.to change(GoalEngagementChange, :count).by(1)
    end
  end
end
