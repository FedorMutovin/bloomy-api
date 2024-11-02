# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:active_task) { create(:task, user:, priority: 0) }
    let!(:closed_task) { create(:task, user:, closed_at: Time.zone.now, priority: 1) }
    let!(:other_user_task) { create(:task, priority: 2) }

    it 'returns only active tasks for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(active_task)
    end

    it 'does not return closed tasks' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(closed_task)
    end

    it 'does not return tasks of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_task)
    end

    context 'with priority' do
      let!(:second_task) { create(:task, user:, priority: 1) }

      it 'sorted by priority: :asc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(active_task)
        expect(result.last).to eq(second_task)
      end
    end
  end
end
