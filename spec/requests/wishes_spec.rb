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
end
