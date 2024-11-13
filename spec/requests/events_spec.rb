# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::EventsController do
  describe 'GET /api/v1/events' do
    let(:user) { create(:user) }

    before do
      create(:goal, user:, initiated_at: 1.day.from_now)
      create(:task, user:, initiated_at: 2.days.from_now)
      create(:travel, user:, initiated_at: 3.days.from_now)
    end

    it 'returns a list of events for a user with expected attributes' do
      # TODO: flaky spec
      get api_v1_events_path(user_id: user.id)

      expect(response).to have_http_status(:success)
      json_response = response.parsed_body

      expect(json_response).to be_an(Array)
      expect(json_response.count).to eq(3)

      expect(json_response[2]['event_type']).to eq('Goal')
      expect(json_response[1]['event_type']).to eq('Task')
      expect(json_response[0]['event_type']).to eq('Travel')
    end
  end
end
