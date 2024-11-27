# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RootsController do
  describe 'POST /api/v1/roots/unite' do
    let(:user) { create(:user)}
    let(:target) { build_stubbed(:goal, user:) }
    let(:source) { build_stubbed(:goal, user:) }

    let!(:params) do
      {
        roots_unite: {
          reason: 'reason',
          target: {
            event_type: target.class.name,
            id: target.id
          },
          source: {
            event_type: source.class.name,
            id: source.id
          }
        }
      }
    end

    let(:roots_unite) do
      build_stubbed(
        :root_unite,
        reason: params[:roots_unite][:reason],
        target_id: params[:roots_unite][:target][:id],
        target_type: params[:roots_unite][:target][:event_type],
        source_id: params[:roots_unite][:source][:id],
        source_type: params[:roots_unite][:source][:event_type],
      )
    end

    let(:stubbed_unite_service) { instance_double(Roots::UniteService) }

    before do
      create(:user)
      allow(Roots::UniteService).to receive(:new).and_return(stubbed_unite_service)
      allow(stubbed_unite_service).to receive(:call).and_return(roots_unite)
    end

    context 'with valid params' do
      it 'unites roots' do
        post(api_v1_roots_unite_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['reason']).to eq(params[:roots_unite][:reason])
        expect(json_response['target_id']).to eq(params[:roots_unite][:target][:id])
        expect(json_response['target_type']).to eq(params[:roots_unite][:target][:event_type])
        expect(json_response['source_id']).to eq(params[:roots_unite][:source][:id])
        expect(json_response['source_type']).to eq(params[:roots_unite][:source][:event_type])
      end
    end
  end
end
