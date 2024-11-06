# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::EventsController do
  xdescribe 'GET /api/v1/events' do
    let(:user) { create(:user) }
    let!(:goal) { create(:goal, user:, initiated_at: 1.day.from_now) }
    let!(:task) { create(:task, user:, initiated_at: 2.days.from_now) }
    let!(:travel) { create(:travel, user:, initiated_at: 3.days.from_now) }
    let(:ids) { [goal.id, task.id, travel.id] }

    before { create(:goal) }

    it 'returns a list of events for a user with expected attributes' do
      # TODO: flaky spec
      get api_v1_events_path(user_id: user.id)

      expect(response).to have_http_status(:success)
      json_response = response.parsed_body

      expect(json_response).to be_an(Array)
      expect(json_response.count).to eq(ids.count)

      expect(json_response[0]['event_type']).to eq('Goal')
      expect(json_response[0]['id']).to eq(goal.id)
      expect(json_response[0]['name']).to eq(goal.name)

      expect(json_response[1]['event_type']).to eq('Task')
      expect(json_response[1]['id']).to eq(task.id)
      expect(json_response[1]['name']).to eq(task.name)

      expect(json_response[2]['event_type']).to eq('Travel')
      expect(json_response[2]['id']).to eq(travel.id)
      expect(json_response[2]['name']).to eq(travel.destination)
    end
  end
end
