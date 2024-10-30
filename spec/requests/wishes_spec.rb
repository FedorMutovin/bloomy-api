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
      end
    end

    # context 'when user does not exist' do
    #   let(:user_id) { '231' }
    #
    #   it 'returns not found' do
    #     get api_v1_wishes_path(user_id:)
    #
    #     expect(response).to have_http_status(:not_found)
    #   end
    # end
  end

  describe 'POST /api/v1/wishes' do
    let(:user) { create(:user) }
    let(:params) { { wishes: { title: 'wish title', description: 'wish description', priority: 1 } } }

    context 'with valid params' do
      before { create(:user) }

      it 'creates wish for the user' do
        post api_v1_wishes_path(params)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Hash)
        expect(json_response['id']).not_to be_nil
        expect(json_response['title']).to eq(params[:wishes][:title])
        expect(json_response['description']).to eq(params[:wishes][:description])
        expect(json_response['priority']).to eq(params[:wishes][:priority])
      end
    end
  end
end
