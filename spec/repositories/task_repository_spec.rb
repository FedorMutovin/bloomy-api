# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user:, priority: 0) }

    before { create(:task) }

    it 'returns wishes only for specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to match_array(task)
    end

    context 'with priority' do
      let!(:second_task) { create(:task, user:, priority: 1) }

      it 'sorted by priority: :asc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(task)
        expect(result.last).to eq(second_task)
      end
    end
  end
end
