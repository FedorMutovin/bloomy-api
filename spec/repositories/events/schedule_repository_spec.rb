# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::ScheduleRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:incomplete_schedule) { create(:event_schedule, :travel, user:, completed: false) }
    let!(:completed_schedule) { create(:event_schedule, :travel, user:, completed: true) }
    let!(:other_user_schedule) { create(:event_schedule, :travel, completed: false) }

    it 'returns only incomplete schedules for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(incomplete_schedule)
    end

    it 'does not return completed schedules' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(completed_schedule)
    end

    it 'does not return schedules of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_schedule)
    end
  end
end