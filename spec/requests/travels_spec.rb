# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TravelsController do
  describe 'GET /api/v1/travels' do
    let(:user) { create(:user) }
    let!(:travel) { create(:travel, user:) }

    context 'when user exists' do
      it 'returns travels for the user' do
        get api_v1_travels_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(travel.id)
        expect(json_response.first['destination']).to eq(travel.destination)
        expect(json_response.first['initiated_at']).to eq(travel.initiated_at.iso8601)
        expect(json_response.first['description']).to eq(travel.description)
      end
    end
  end
end
