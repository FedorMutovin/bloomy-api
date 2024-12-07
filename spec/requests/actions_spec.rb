# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ActionsController do
  describe 'GET /api/v1/actions' do
    let(:user) { create(:user) }
    let!(:action) { create(:action, user:) }

    context 'when user exists' do
      it 'returns actions for the user' do
        get api_v1_actions_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(action.id)
        expect(json_response.first['name']).to eq(action.name)
        expect(json_response.first['initiated_at']).to eq(action.initiated_at.iso8601)
        expect(json_response.first['description']).to eq(action.description)
      end
    end
  end

  describe 'POST /api/v1/actions' do
    let(:initiated_at) { '2024-11-11T17:03:32Z' }
    let!(:params) do
      {
        root_action: {
          name: 'action name',
          description: 'action description',
          initiated_at:,
          origin_root: {
            id: 'root_id',
            root_type: 'some_root_type',
            name: 'Root name'
          }
        }
      }
    end

    let(:action) do
      build_stubbed(
        :action,
        name: params[:root_action][:name],
        description: params[:root_action][:description],
        initiated_at: params[:root_action][:initiated_at]
      )
    end

    let(:stubbed_create_service) { instance_double(Actions::CreateService) }

    before do
      create(:user)
      allow(Actions::CreateService).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(action)
    end

    context 'with valid params' do
      it 'creates a action for the user' do
        post(api_v1_actions_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['name']).to eq(params[:root_action][:name])
        expect(json_response['description']).to eq(params[:root_action][:description])
        expect(json_response['initiated_at']).to eq(params[:root_action][:initiated_at])
      end
    end
  end
end
