# frozen_string_literal: true

# spec/requests/api/v1/goals_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::GoalsController do
  describe 'GET /api/v1/goals' do
    let(:user) { create(:user) }

    context 'when user exists' do
      before { create(:goal, user:) }

      it 'returns goals for the user' do
        get api_v1_goals_path(user_id: user.id)

        body = response.parsed_body

        expect(response).to have_http_status(:ok)
        expect(body.size).to eq(1)
        expect(body.first).to include('id', 'name', 'created_at')
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
