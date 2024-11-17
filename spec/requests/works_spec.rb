# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::WorksController do
  describe 'GET /api/v1/works' do
    let(:user) { create(:user) }
    let(:work) { create(:work, user:) }

    context 'when user exists' do
      before { create(:work_load, work:) }

      it 'returns works for the user' do
        get api_v1_works_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(work.id)
        expect(json_response.first['company_name']).to eq(work.company_name)
        expect(json_response.first['position_name']).to eq(work.position_name)
        expect(json_response.first['start_date']).to eq(work.start_date.to_s)
        expect(json_response.first['start_date']).to eq(work.start_date.to_s)
        expect(json_response.first['work_load']).to eq(work.work_load.value)
      end
    end
  end
end
