# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::ScheduleRepository do
  describe '.by_user_id(user_id)' do
    let(:user) { create(:user) }
    let!(:incomplete_schedule) { create(:root_schedule, :travel, user:, completed: false) }
    let!(:completed_schedule) { create(:root_schedule, :travel, user:, completed: true) }
    let!(:other_user_schedule) { create(:root_schedule, :travel, completed: false) }

    it 'returns only incomplete schedules for the specific user' do
      expect(described_class.by_user_id(user.id)).to contain_exactly(incomplete_schedule)
    end

    it 'does not return completed schedules' do
      result = described_class.by_user_id(user.id)
      expect(result).not_to include(completed_schedule)
    end

    it 'does not return schedules of other users' do
      result = described_class.by_user_id(user.id)
      expect(result).not_to include(other_user_schedule)
    end
  end

  describe 'add(**params)' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user:) }
    let(:params) do
      {
        scheduable_id: task.id,
        scheduable_type: task.class.name,
        user_id: user.id,
        scheduled_at: Time.zone.now
      }
    end

    it 'creates a Roots::Schedules' do
      expect { described_class.add(**params) }.to change(Roots::Schedule, :count).by(1)
    end
  end
end
