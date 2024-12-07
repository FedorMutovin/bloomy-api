# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::HobbiesController do
  describe 'GET /api/v1/hobbies' do
    let(:user) { create(:user) }
    let!(:hobby) { create(:hobby, user:) }

    context 'when user exists' do
      it 'returns hobbies for the user' do
        get api_v1_hobbies_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(hobby.id)
        expect(json_response.first['name']).to eq(hobby.name)
        expect(json_response.first['initiated_at']).to eq(hobby.initiated_at.iso8601)
        expect(json_response.first['skill_level']).to eq(hobby.skill_level)
        expect(json_response.first['engagement_level']).to eq(hobby.engagement_level)
      end
    end
  end

  describe 'POST /api/v1/hobbies' do
    let(:initiated_at) { '2024-11-11T17:03:32Z' }
    let!(:params) do
      {
        hobby: {
          name: 'hobby name',
          skill_level: 1,
          engagement_level: 2,
          initiated_at:,
          trigger: {
            id: 'trigger_id',
            event_type: 'some_event_type',
            name: 'Trigger name'
          }
        }
      }
    end

    let(:hobby) do
      build_stubbed(
        :hobby,
        name: params[:hobby][:name],
        skill_level: params[:hobby][:skill_level],
        engagement_level: params[:hobby][:engagement_level],
        initiated_at: params[:hobby][:initiated_at]
      )
    end

    let(:stubbed_create_service) { instance_double(Hobbies::CreateService) }

    before do
      create(:user)
      allow(Hobbies::CreateService).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(hobby)
    end

    context 'with valid params' do
      it 'creates a hobby for the user' do
        post(api_v1_hobbies_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['name']).to eq(params[:hobby][:name])
        expect(json_response['skill_level']).to eq(params[:hobby][:skill_level])
        expect(json_response['engagement_level']).to eq(params[:hobby][:engagement_level])
        expect(json_response['initiated_at']).to eq(params[:hobby][:initiated_at])
      end
    end
  end
end
