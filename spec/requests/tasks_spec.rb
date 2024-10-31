# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TasksController do
  describe 'GET /api/v1/tasks' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user:) }

    context 'when user exists' do
      it 'returns tasks for the user' do
        get api_v1_tasks_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(task.id)
        expect(json_response.first['name']).to eq(task.name)
        expect(json_response.first['description']).to eq(task.description)
        expect(json_response.first['status']).to eq(task.status)
        expect(json_response.first['priority']).to eq(task.priority)
        expect(json_response.first['initiated_at']).to eq(task.initiated_at.iso8601(3))
      end
    end
  end
end
