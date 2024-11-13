# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let(:goal) { create(:goal, user:) }
    let!(:other_user_goal) { create(:goal) }
    let(:task) { create(:task, user:) }
    let(:travel) { create(:travel, user:) }
    let!(:ids) { [goal.id, travel.id, task.id] }

    it 'returns only events for the specific user' do
      result = described_class.by_user_id(user_id: user.id).map(&:id)
      expect(result).to match_array(ids)
    end

    it 'does not return goals of other users' do
      result = described_class.by_user_id(user_id: user.id).map(&:id)
      expect(result).not_to include(other_user_goal)
    end

    context 'with ordering by initiated_at asc' do
      let!(:goal) { create(:goal, user:, initiated_at: 1.day.from_now) }
      let!(:task) { create(:task, user:, initiated_at: 2.days.from_now) }
      let!(:travel) { create(:travel, user:, initiated_at: 3.days.from_now) }

      it 'returns events ordered by initiated_at' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result[2]['id']).to eq(goal.id)
        expect(result[1]['id']).to eq(task.id)
        expect(result[0]['id']).to eq(travel.id)
      end
    end
  end
end
