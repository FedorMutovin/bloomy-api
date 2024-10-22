# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event::ScheduleRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:event_schedule) { create(:event_schedule, :travel, user:) }

    before { create(:event_schedule, :travel) }

    it 'returns schedules only for specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to match_array(event_schedule)
    end
  end
end
