# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:active_goal) { create(:goal, user:, closed: false) }
    let!(:closed_goal) { create(:goal, user:, closed: true) }
    let!(:other_user_goal) { create(:goal, closed: false) }

    it 'returns only active goals for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(active_goal)
    end

    it 'does not return closed goals' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(closed_goal)
    end

    it 'does not return goals of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_goal)
    end
  end

  describe '.by_id(id:)' do
    let(:user) { create(:user) }
    let!(:goal) { create(:goal, user:, closed: false) }

    it 'returns only goal for the specified id' do
      expect(described_class.by_id(id: goal.id)).to eq goal
    end
  end
end
