# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DecisionsController do
  describe 'GET /api/v1/decisions' do
    let(:user) { create(:user) }
    let!(:decision) { create(:decision, user:) }

    context 'when user exists' do
      it 'returns decisions for the user' do
        get api_v1_decisions_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(decision.id)
        expect(json_response.first['name']).to eq(decision.name)
        expect(json_response.first['initiated_at']).to eq(decision.initiated_at.iso8601)
        expect(json_response.first['description']).to eq(decision.description)
      end
    end
  end

  describe 'POST /api/v1/decisions' do
    let(:initiated_at) { '2024-11-11T17:03:32Z' }
    let!(:params) do
      {
        decision: {
          name: 'decision name',
          description: 'decision description',
          initiated_at:,
          trigger: {
            id: 'trigger_id',
            event_type: 'some_event_type',
            name: 'Trigger name'
          }
        }
      }
    end

    let(:decision) do
      build_stubbed(
        :decision,
        name: params[:decision][:name],
        description: params[:decision][:description],
        initiated_at: params[:decision][:initiated_at]
      )
    end

    let(:stubbed_create_service) { instance_double(Decisions::Create) }

    before do
      create(:user)
      allow(Decisions::Create).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(decision)
    end

    context 'with valid params' do
      it 'creates a decision for the user' do
        post(api_v1_decisions_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['name']).to eq(params[:decision][:name])
        expect(json_response['description']).to eq(params[:decision][:description])
        expect(json_response['initiated_at']).to eq(params[:decision][:initiated_at])
      end
    end
  end
end
