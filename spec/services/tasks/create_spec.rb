# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'Test Task',
      description: 'Task description',
      priority: 1,
      initiated_at: DateTime.current,
      started_at: DateTime.current - 1.hour,
      status: Status::IN_PROGRESS
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a task' do
      it 'creates a new task with the specified attributes' do
        allow(TaskRepository).to receive(:add)
        service_call
        expect(TaskRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'goal-id', event_type: 'Goal' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:task) { build_stubbed(:task, user:, name: 'Test Task', description: 'Task description') }

      it 'adds an event relationship if trigger is present' do
        allow(TaskRepository).to receive(:add).and_return(task)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: task.id,
          impactable_type: task.class.name
        )
      end
    end

    context 'when adding a schedule' do
      let(:schedule_params) do
        { schedule: { scheduled_at: DateTime.current + 1.day } }
      end
      let(:params) { attributes.merge(schedule_params) }
      let(:task) { build_stubbed(:task, user:, name: 'Test Task', description: 'Task description') }

      it 'adds a schedule if schedule is present' do
        allow(TaskRepository).to receive(:add).and_return(task)
        allow(Events::ScheduleRepository).to receive(:add)

        service_call

        expect(Events::ScheduleRepository).to have_received(:add).with(
          scheduable_id: task.id,
          scheduable_type: task.class.name,
          scheduled_at: schedule_params[:schedule][:scheduled_at],
          user_id: user.id,
          details: { name: task.name, description: task.description }
        )
      end
    end

    context 'when trigger and schedule are both present' do
      let(:params) do
        attributes.merge(trigger: { id: 'goal-id', event_type: 'Goal' },
                         schedule: { scheduled_at: DateTime.current + 1.day })
      end
      let(:task) { build_stubbed(:task, user:, name: 'Test Task', description: 'Task description') }

      it 'creates task, adds event relationship, and adds schedule within a transaction' do
        allow(TaskRepository).to receive(:add).and_return(task)
        allow(Events::RelationshipRepository).to receive(:add)
        allow(Events::ScheduleRepository).to receive(:add)

        service_call

        expect(TaskRepository).to have_received(:add)
        expect(Events::RelationshipRepository).to have_received(:add)
        expect(Events::ScheduleRepository).to have_received(:add)
      end
    end

    context 'when adding engagement changes' do
      let(:engagement_changes) do
        { engagement_changes: { value: 1 } }
      end
      let(:params) { attributes.merge(engagement_changes) }
      let(:task) { build_stubbed(:task, user:, name: 'task', description: 'task description') }

      it 'adds an engagement change if engagement_changes is present' do
        allow(TaskRepository).to receive(:add).and_return(task)
        allow(TaskEngagementRepository).to receive(:add)

        service_call

        expect(TaskEngagementRepository).to have_received(:add).with(
          task_id: task.id,
          value: params[:engagement_changes][:value]
        )
      end
    end
  end
end
