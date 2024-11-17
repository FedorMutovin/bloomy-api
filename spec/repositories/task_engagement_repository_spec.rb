# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskEngagementRepository do
  describe '.add(params)' do
    let(:task) { create(:task) }
    let(:params) do
      { value: 1, task_id: task.id }
    end

    it 'creates a task engagement' do
      expect { described_class.add(**params) }.to change(TaskEngagement, :count).by(1)
    end
  end

  describe '.by_task_id(task_id)' do
    let(:task) { create(:task) }
    let!(:task_engagement) { create(:task_engagement, task:) }

    it 'finds a task engagement for the specific task' do
      expect(described_class.by_task_id(task.id)).to eq(task_engagement)
    end
  end

  describe '.update(id, params)' do
    let(:task_engagement) { create(:task_engagement) }
    let(:params) do
      { value: 2 }
    end

    it 'updates a task engagement' do
      expect(task_engagement.value).not_to eq(2)
      described_class.update(task_engagement.id, **params)
      expect(task_engagement.reload.value).to eq(2)
    end
  end
end
