# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:active_task) { create(:task, user:, priority: 0) }
    let!(:closed_task) { create(:task, user:, closed_at: Time.zone.now, priority: 1) }
    let!(:postponed_task) { create(:task, user:, postponed_at: Time.zone.now, priority: 1) }
    let!(:other_user_task) { create(:task, priority: 2) }

    it 'returns only active tasks for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(active_task)
    end

    it 'does not return closed tasks' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(closed_task)
    end

    it 'does not return postponed tasks' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(postponed_task)
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

  describe '.add(**params)' do
    let(:user) { create(:user) }
    let(:params) do
      { name: 'task name', description: 'task description', priority: 1, user_id: user.id, initiated_at: Time.zone.now }
    end

    it 'creates a task' do
      expect { described_class.add(**params) }.to change(Task, :count).by(1)
    end
  end

  describe '.by_id(id:)' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user:) }

    it 'returns only task for the specified id' do
      expect(described_class.by_id(id: task.id)).to eq task
    end
  end

  describe '.postponed_tasks(time)' do
    let(:user) { create(:user) }
    let!(:active_task) { create(:task, user:, postponed_until: 1.day.ago) }

    it 'returns tasks postponed until the specified time' do
      result = described_class.postponed_tasks(Time.zone.now)
      expect(result).to eq([active_task])
    end
  end

  describe '.update_tasks(tasks, params)' do
    let(:user) { create(:user) }
    let!(:postponed_task) do
      create(:task, user:, postponed_at: 1.day.ago, postponed_until: 1.day.ago, status: Status::IN_PROGRESS)
    end

    let(:params) do
      { postponed_at: nil, postponed_until: nil, status: Status::PENDING }
    end

    it 'updates the given tasks with new parameters' do
      described_class.update_tasks([postponed_task], params)
      expect(postponed_task.reload.postponed_at).to be_nil
      expect(postponed_task.reload.postponed_until).to be_nil
      expect(postponed_task.reload.status).to eq(Status::PENDING)
    end
  end
end
