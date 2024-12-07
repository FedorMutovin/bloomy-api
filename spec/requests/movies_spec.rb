# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  describe 'GET /api/v1/movies' do
    let(:user) { create(:user) }
    let!(:movie) { create(:movie, user:) }

    context 'when user exists' do
      it 'returns movies for the user' do
        get api_v1_movies_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(movie.id)
        expect(json_response.first['name']).to eq(movie.name)
        expect(json_response.first['status']).to eq(movie.status)
        expect(json_response.first['rating']).to eq(movie.rating)
        expect(json_response.first['completed_at']).to eq(movie.completed_at)
        expect(json_response.first['initiated_at']).to eq(movie.initiated_at.iso8601)
      end
    end
  end

  describe 'POST /api/v1/movies' do
    let!(:params) do
      {
        movie: {
          name: 'movie name',
          status: 'watched',
          rating: 'interesting',
          completed_at: '2024-11-11T17:03:32Z',
          initiated_at: '2024-11-10T17:03:32Z',
          trigger: {
            id: 'trigger_id',
            event_type: 'some_event_type',
            name: 'Trigger name'
          }
        }
      }
    end

    let(:movie) do
      build_stubbed(
        :movie,
        name: params[:movie][:name],
        status: params[:movie][:status],
        rating: params[:movie][:rating],
        completed_at: params[:movie][:completed_at],
        initiated_at: params[:movie][:initiated_at]
      )
    end

    let(:stubbed_create_service) { instance_double(Movies::CreateService) }

    before do
      create(:user)
      allow(Movies::CreateService).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(movie)
    end

    context 'with valid params' do
      it 'creates a movie for the user' do
        post(api_v1_movies_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['name']).to eq(params[:movie][:name])
        expect(json_response['status']).to eq(params[:movie][:status])
        expect(json_response['rating']).to eq(params[:movie][:rating])
        expect(json_response['completed_at']).to eq(params[:movie][:completed_at])
        expect(json_response['initiated_at']).to eq(params[:movie][:initiated_at])
      end
    end
  end
end
