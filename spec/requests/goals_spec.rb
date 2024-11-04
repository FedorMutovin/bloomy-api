# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoalsController do
  describe 'GET /api/v1/goals' do
    let(:user) { create(:user) }
    let!(:goal) { create(:goal, user:, status: 'pending') }

    context 'when user exists' do
      it 'returns goals for the user' do
        get api_v1_goals_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(goal.id)
        expect(json_response.first['name']).to eq(goal.name)
        expect(json_response.first['initiated_at']).to eq(goal.initiated_at.iso8601(3))
        expect(json_response.first['status']).to eq(goal.status)
        expect(json_response.first['closed_at']).to eq(goal.closed_at)
        expect(json_response.first['started_at']).to eq(goal.started_at.iso8601(3))
        expect(json_response.first['priority']).to eq(goal.priority)
        expect(json_response.first['tasks']).to be_nil
      end
    end
  end

  describe 'GET /api/v1/goals/:id' do
    let(:user) { create(:user) }
    let(:goal) { create(:goal, user:, status: 'pending') }

    context 'when goal exists' do
      before { create(:task, user:, goal:) }

      it 'returns goal for the user with associations' do
        get api_v1_goal_path(id: goal.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response).to be_an(Hash)
        expect(json_response['id']).to eq(goal.id)
        expect(json_response['name']).to eq(goal.name)
        expect(json_response['initiated_at']).to eq(goal.initiated_at.iso8601(3))
        expect(json_response['status']).to eq(goal.status)
        expect(json_response['closed_at']).to eq(goal.closed_at)
        expect(json_response['started_at']).to eq(goal.started_at.iso8601(3))
        expect(json_response['priority']).to eq(goal.priority)
        expect(json_response['tasks']).not_to be_nil
      end
    end

    context 'when user does not exist' do
      let(:goal_id) { '231' }

      it 'returns not found' do
        get api_v1_goal_path(id: goal_id)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/goals' do
    let(:user) { create(:user) }
    let(:initiated_at) { '2024-10-31T17:50:21.000Z' }
    let(:params) do
      {
        goal:
          {
            name: ' goal name',
            description: 'goal description',
            priority: 1,
            initiated_at:,
            tasks_attributes: [
              {
                name: 'task name',
                description: 'task description',
                initiated_at: Time.current
              }
            ]
          }
      }
    end

    context 'with valid params' do
      before { create(:user) }

      it 'creates goal for the user' do
        post api_v1_goals_path(params)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Hash)
        expect(json_response['id']).not_to be_nil
        expect(json_response['name']).to eq(params[:goal][:name])
        expect(json_response['description']).to eq(params[:goal][:description])
        expect(json_response['priority']).to eq(params[:goal][:priority])
        expect(json_response['initiated_at']).to eq(params[:goal][:initiated_at])
        expect(json_response['tasks']).to be_nil
      end
    end
  end
end
