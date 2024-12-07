# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TasksController do
  describe 'GET /api/v1/tasks' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user:, deadline_at: DateTime.current) }

    context 'when user exists' do
      it 'returns tasks for the user' do
        get api_v1_tasks_path

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_an(Array)
        expect(json_response.size).to eq(1)
        expect(json_response.first['id']).to eq(task.id)
        expect(json_response.first['name']).to eq(task.name)
        expect(json_response.first['description']).to eq(task.description)
        expect(json_response.first['status']).to eq(task.status)
        expect(json_response.first['priority']).to eq(task.priority)
        expect(json_response.first['initiated_at']).to eq(task.initiated_at.iso8601)
        expect(json_response.first['deadline_at']).to eq(task.deadline_at.iso8601)
      end
    end
  end

  describe 'POST /api/v1/tasks' do
    let(:initiated_at) { '2024-11-11T17:03:32Z' }
    let(:started_at) { '2024-11-11T17:03:32Z' }
    let(:deadline_at) { '2025-01-22T17:03:32Z' }
    let!(:params) do
      {
        task: {
          name: 'Task name',
          description: 'Task description',
          priority: 1,
          started_at:,
          status: Status::IN_PROGRESS,
          initiated_at:,
          deadline_at:,
          trigger: {
            id: 'trigger_id',
            event_type: 'some_event_type',
            name: 'Trigger name'
          }
        }
      }
    end

    let(:task) do
      build_stubbed(
        :task,
        name: params[:task][:name],
        description: params[:task][:description],
        priority: params[:task][:priority],
        initiated_at: params[:task][:initiated_at],
        started_at: params[:task][:started_at],
        status: params[:task][:status],
        deadline_at: params[:task][:deadline_at]
      )
    end

    let(:stubbed_create_service) { instance_double(Tasks::CreateService) }

    before do
      create(:user)
      allow(Tasks::CreateService).to receive(:new).and_return(stubbed_create_service)
      allow(stubbed_create_service).to receive(:call).and_return(task)
    end

    context 'with valid params' do
      it 'creates a task for the user' do
        post(api_v1_tasks_path, params:)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body

        expect(json_response).to be_a(Hash)
        expect(json_response['name']).to eq(params[:task][:name])
        expect(json_response['description']).to eq(params[:task][:description])
        expect(json_response['priority']).to eq(params[:task][:priority])
        expect(json_response['initiated_at']).to eq(params[:task][:initiated_at])
        expect(json_response['started_at']).to eq(params[:task][:started_at])
        expect(json_response['status']).to eq(params[:task][:status])
        expect(json_response['deadline_at']).to eq(params[:task][:deadline_at])
      end
    end
  end

  describe 'GET /api/v1/tasks/:id' do
    let(:user) { create(:user) }
    let(:task) { create(:task, user:, status: 'pending', started_at: DateTime.current) }
    let!(:task_engagement) { create(:task_engagement, value: 1, task:) }

    context 'when task exists' do
      it 'returns task for the user with associations' do
        get api_v1_task_path(id: task.id)

        expect(response).to have_http_status(:success)
        json_response = response.parsed_body
        expect(json_response).to be_an(Hash)
        expect(json_response['id']).to eq(task.id)
        expect(json_response['name']).to eq(task.name)
        expect(json_response['initiated_at']).to eq(task.initiated_at.iso8601)
        expect(json_response['status']).to eq(task.status)
        expect(json_response['closed_at']).to eq(task.closed_at)
        expect(json_response['started_at']).to eq(task.started_at.iso8601)
        expect(json_response['priority']).to eq(task.priority)
        expect(json_response['engagement']).to eq(task_engagement.value)
      end
    end

    context 'when task does not exist' do
      let(:user) { create(:user) }
      let(:task_id) { '231' }

      it 'returns not found' do
        get api_v1_task_path(id: task_id)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
