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
        expect(json_response.first['start_at']).to eq(travel.start_at.iso8601)
        expect(json_response.first['end_at']).to eq(travel.end_at.iso8601)
      end
    end
  end

  describe 'POST /api/v1/travels' do
    let(:initiated_at) { '2024-11-11T17:03:32Z' }
    let(:start_at) { '2024-11-11T17:03:32Z' }
    let(:end_at) { '2024-11-20T17:03:32Z' }
    let!(:params) do
      {
        travel: {
          destination: 'travel destination',
          description: 'travel description',
          start_at:,
          end_at:,
          initiated_at:,
          trigger: {
            id: 'trigger_id',
            event_type: 'some_event_type',
            name: 'Trigger name'
          }
        }
      }
    end

    let(:travel) do
      build_stubbed(
        :travel,
        destination: params[:travel][:destination],
        description: params[:travel][:description],
        initiated_at: params[:travel][:initiated_at],
        start_at: params[:travel][:start_at],
        end_at: params[:travel][:end_at]
      )
    end

    let(:stubbed_create_service) { instance_double(Travels::CreateService) }

    before do
      create(:user)
      allow(Travels::CreateService).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(travel)
    end

    context 'with valid params' do
      it 'creates a travel for the user' do
        post(api_v1_travels_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['destination']).to eq(params[:travel][:destination])
        expect(json_response['description']).to eq(params[:travel][:description])
        expect(json_response['initiated_at']).to eq(params[:travel][:initiated_at])
        expect(json_response['start_at']).to eq(params[:travel][:start_at])
        expect(json_response['end_at']).to eq(params[:travel][:end_at])
      end
    end
  end
end
