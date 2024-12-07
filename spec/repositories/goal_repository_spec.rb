# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalRepository do
  describe '.by_user_id(user_id)' do
    let(:user) { create(:user) }
    let!(:active_goal) { create(:goal, user:, priority: 0) }
    let!(:closed_goal) { create(:goal, user:, closed_at: Time.zone.now, priority: 1) }
    let!(:postponed_goal) { create(:goal, user:, postponed_at: Time.zone.now, priority: 1) }
    let!(:other_user_goal) { create(:goal, priority: 2) }

    it 'returns only active goals for the specific user' do
      expect(described_class.by_user_id(user.id)).to contain_exactly(active_goal)
    end

    it 'does not return closed goals' do
      result = described_class.by_user_id(user.id)
      expect(result).not_to include(closed_goal)
    end

    it 'does not return postponed goals' do
      result = described_class.by_user_id(user.id)
      expect(result).not_to include(postponed_goal)
    end

    it 'does not return goals of other users' do
      result = described_class.by_user_id(user.id)
      expect(result).not_to include(other_user_goal)
    end

    context 'with priority' do
      let!(:second_active_goal) { create(:goal, user:, priority: 1) }

      it 'sorted by priority: :asc' do
        result = described_class.by_user_id(user.id)
        expect(result.first).to eq(active_goal)
        expect(result.last).to eq(second_active_goal)
      end
    end

    context 'with united goal' do
      let!(:united_goal) { create(:goal, user:, status: Status::UNITED) }

      it 'does not return united goals' do
        result = described_class.by_user_id(user.id)
        expect(result).to include(active_goal)
        expect(result).not_to include(united_goal)
      end
    end
  end

  describe '.by_id(id)' do
    let(:user) { create(:user) }
    let!(:goal) { create(:goal, user:) }

    it 'returns only goal for the specified id' do
      expect(described_class.by_id(goal.id)).to eq goal
    end
  end

  describe '.add(params)' do
    let(:user) { create(:user) }
    let(:params) do
      { name: 'goal name', description: 'goal description', priority: 1, user_id: user.id, initiated_at: Time.zone.now }
    end

    it 'creates a goal' do
      expect { described_class.add(**params) }.to change(Goal, :count).by(1)
    end
  end

  describe '.update(id, **params)' do
    let(:user) { create(:user) }
    let!(:goal) do
      create(:goal, user:, name: 'goal', initiated_at: 1.day.ago, priority: 1, status: Status::IN_PROGRESS)
    end

    let(:params) do
      { name: 'updated goal', initiated_at: 2.days.ago, status: Status::PENDING }
    end

    it 'updates the given task with new parameters' do
      original_name = goal.name
      original_initiated_at = goal.initiated_at
      original_status = goal.status

      described_class.update(goal.id, **params)

      expect(goal.reload.postponed_at).not_to eq(original_name)
      expect(goal.reload.postponed_until).not_to eq(original_initiated_at)
      expect(goal.reload.status).not_to eq(original_status)
    end
  end
end
