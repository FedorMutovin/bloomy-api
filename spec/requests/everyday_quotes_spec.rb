# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoalsController do
  describe 'GET /api/v1/everyday_quotes' do
    let(:user) { create(:user) }
    let!(:everyday_quote) { create(:everyday_quote, user:) }

    context 'when user exists' do
      it 'returns goals for the user' do
        get api_v1_everyday_quotes_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(everyday_quote.id)
        expect(json_response.first['description']).to eq(everyday_quote.description)
      end
    end
  end
end
