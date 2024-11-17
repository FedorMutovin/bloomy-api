# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskEngagementChangeRepository do
  describe '.add(params)' do
    let(:task_engagement) { create(:task_engagement) }
    let(:params) do
      { last_value: 0, new_value: 2, engagement: task_engagement, reason: 'reason', initiated_at: DateTime.current }
    end

    it 'creates a task engagement change' do
      expect { described_class.add(**params) }.to change(TaskEngagementChange, :count).by(1)
    end
  end
end
