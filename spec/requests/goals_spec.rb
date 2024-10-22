# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoalsController do
  describe 'GET /api/v1/goals' do
    let(:user) { create(:user) }
    let!(:goal) { create(:goal, user:, status: 'pending') }

    context 'when user exists' do
      it 'returns goals for the user' do
        get api_v1_goals_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(goal.id)
        expect(json_response.first['name']).to eq(goal.name)
        expect(json_response.first['created_at']).to eq(goal.created_at.as_json)
        expect(json_response.first['status']).to eq(goal.status)
        expect(json_response.first['closed']).to eq(goal.closed)
        expect(json_response.first['closed_at']).to eq(goal.closed_at)
        expect(json_response.first['started_at']).to eq(goal.started_at)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { '231' }

      it 'returns not found' do
        get api_v1_goals_path(user_id:)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
