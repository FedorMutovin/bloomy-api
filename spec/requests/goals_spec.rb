# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GoalsController do
  describe 'GET /api/v1/goals' do
    let(:user) { create(:user) }
    let(:goal) { create(:goal, user:, status: 'pending') }
    let!(:goal_engagement) { create(:goal_engagement, value: 1, goal:) }

    context 'when user exists' do
      it 'returns goals for the user' do
        get api_v1_goals_path(user_id: user.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(goal.id)
        expect(json_response.first['name']).to eq(goal.name)
        expect(json_response.first['initiated_at']).to eq(goal.initiated_at.iso8601)
        expect(json_response.first['status']).to eq(goal.status)
        expect(json_response.first['closed_at']).to eq(goal.closed_at)
        expect(json_response.first['started_at']).to eq(goal.started_at.iso8601)
        expect(json_response.first['priority']).to eq(goal.priority)
        expect(json_response.first['engagement']).to eq(goal_engagement.value)
      end
    end
  end

  describe 'GET /api/v1/goals/:id' do
    let(:user) { create(:user) }
    let(:goal) { create(:goal, user:, status: 'pending') }
    let!(:goal_engagement) { create(:goal_engagement, value: 1, goal:) }

    context 'when goal exists' do
      it 'returns goal for the user with associations' do
        get api_v1_goal_path(id: goal.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response).to be_an(Hash)
        expect(json_response['id']).to eq(goal.id)
        expect(json_response['name']).to eq(goal.name)
        expect(json_response['initiated_at']).to eq(goal.initiated_at.iso8601)
        expect(json_response['status']).to eq(goal.status)
        expect(json_response['closed_at']).to eq(goal.closed_at)
        expect(json_response['started_at']).to eq(goal.started_at.iso8601)
        expect(json_response['priority']).to eq(goal.priority)
        expect(json_response['engagement']).to eq(goal_engagement.value)
      end
    end

    context 'when goal does not exist' do
      let(:user) { create(:user) }
      let(:goal_id) { '231' }

      it 'returns not found' do
        get api_v1_goal_path(id: goal_id)

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/goals' do
    let(:initiated_at) { '2024-11-11T17:03:32Z' }
    let(:started_at) { '2024-11-11T17:03:32Z' }
    let!(:params) do
      {
        goal: {
          name: 'Goal name',
          description: 'Goal description',
          priority: 1,
          started_at:,
          status: Status::IN_PROGRESS,
          initiated_at:,
          trigger: {
            id: 'trigger_id',
            event_type: 'some_event_type',
            name: 'Trigger name'
          }
        }
      }
    end

    let(:goal) do
      build_stubbed(
        :goal,
        name: params[:goal][:name],
        description: params[:goal][:description],
        priority: params[:goal][:priority],
        initiated_at: params[:goal][:initiated_at],
        started_at: params[:goal][:started_at],
        status: params[:goal][:status]
      )
    end

    let(:stubbed_create_service) { instance_double(Goals::Create) }

    before do
      create(:user)
      allow(Goals::Create).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(goal)
    end

    context 'with valid params' do
      it 'creates a goal for the user' do
        post(api_v1_goals_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['name']).to eq(params[:goal][:name])
        expect(json_response['description']).to eq(params[:goal][:description])
        expect(json_response['priority']).to eq(params[:goal][:priority])
        expect(json_response['initiated_at']).to eq(params[:goal][:initiated_at])
        expect(json_response['started_at']).to eq(params[:goal][:started_at])
        expect(json_response['status']).to eq(params[:goal][:status])
      end
    end
  end
end
