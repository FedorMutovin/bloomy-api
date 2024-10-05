# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalRepository do
  describe '.all' do
    let!(:goals) { create_pair(:goal) }

    it 'returns all goals' do
      expect(described_class.all).to match_array(goals)
    end
  end

  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:goal) { create(:goal, user:) }

    before { create(:goal) }

    it 'returns goals only for specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to match_array(goal)
    end
  end
end
