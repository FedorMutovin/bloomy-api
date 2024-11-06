# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SchedulesController do
  describe 'GET /api/v1/schedules' do
    let(:user) { create(:user) }
    let(:travel) { create(:travel, user:, destination: 'Paris') }
    let(:scheduled_time) { 10.days.from_now }
    let(:completed) { false }
    let!(:schedule) do
      create(:event_schedule,
             user:,
             scheduable: travel,
             scheduled_at: scheduled_time,
             details: { destination: travel.destination },
             completed:)
    end

    it 'returns a list of schedules for a user' do
      get api_v1_schedules_path(user_id: user.id)

      expect(response).to have_http_status(:success)
      json_response = response.parsed_body

      expect(json_response).to be_an(Array)
      expect(json_response.first['id']).to eq(schedule.id)
      expect(json_response.first['scheduled_at']).to eq(scheduled_time.as_json)
      expect(json_response.first['scheduable_type']).to eq('Travel')
      expect(json_response.first['scheduable_id']).to eq(travel.id)
      expect(json_response.first['completed']).to be(false)
      expect(json_response.first['details']['destination']).to eq(travel.destination)
    end
  end
end
