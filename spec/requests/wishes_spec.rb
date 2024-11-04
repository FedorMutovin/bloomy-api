# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::WishesController do
  describe 'GET /api/v1/wishes' do
    let(:user) { create(:user) }
    let!(:wish) { create(:wish, user:) }

    context 'when user exists' do
      it 'returns wishes for the user' do
        get api_v1_wishes_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(wish.id)
        expect(json_response.first['title']).to eq(wish.title)
        expect(json_response.first['description']).to eq(wish.description)
        expect(json_response.first['priority']).to eq(wish.priority)
        expect(json_response.first['initiated_at']).to eq(wish.initiated_at.iso8601(3))
      end
    end
  end

  describe 'GET /api/v1/wishes/:id' do
    let(:user) { create(:user) }
    let(:wish) { create(:wish, user:) }

    context 'when wish exists' do
      it 'returns wish for the user' do
        get api_v1_wish_path(id: wish.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response).to be_an(Hash)
        expect(json_response['id']).to eq(wish.id)
        expect(json_response['title']).to eq(wish.title)
        expect(json_response['description']).to eq(wish.description)
        expect(json_response['initiated_at']).to eq(wish.initiated_at.iso8601(3))
      end
    end

    context 'when user does not exist' do
      let(:wish_id) { '231' }

      it 'returns not found' do
        get api_v1_wish_path(id: wish_id)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/wishes' do
    let(:user) { create(:user) }
    let(:initiated_at) { '2024-10-31T17:50:21.000Z' }
    let(:params) do
      { wish: { title: 'wish title', description: 'wish description', priority: 1, initiated_at: } }
    end

    context 'with valid params' do
      before { create(:user) }

      it 'creates wish for the user' do
        post api_v1_wishes_path(params)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Hash)
        expect(json_response['id']).not_to be_nil
        expect(json_response['title']).to eq(params[:wish][:title])
        expect(json_response['description']).to eq(params[:wish][:description])
        expect(json_response['priority']).to eq(params[:wish][:priority])
        expect(json_response['initiated_at']).to eq(params[:wish][:initiated_at])
      end
    end
  end
end
