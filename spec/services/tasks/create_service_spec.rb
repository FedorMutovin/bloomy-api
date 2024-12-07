# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { TaskRepository }
    let(:record_factory) { :task }
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

    context 'when adding a schedule' do
      let(:schedule_params) do
        { schedule: { scheduled_at: DateTime.current + 1.day } }
      end
      let(:params) { attributes.merge(schedule_params) }
      let(:task) { build_stubbed(record_factory, attributes.merge(user:)) }

      it 'adds a schedule if schedule is present' do
        allow(TaskRepository).to receive(:add).and_return(task)
        allow(Roots::ScheduleRepository).to receive(:add)

        service_call

        expect(Roots::ScheduleRepository).to have_received(:add).with(
          scheduable_id: task.id,
          scheduable_type: task.class.name,
          scheduled_at: schedule_params[:schedule][:scheduled_at],
          user_id: user.id,
          details: { name: task.name, description: task.description }
        )
      end
    end

    context 'when adding engagement changes' do
      let(:engagement_changes) do
        { engagement_changes: { value: 1 } }
      end
      let(:params) { attributes.merge(engagement_changes) }
      let(:task) { build_stubbed(record_factory, attributes.merge(user:)) }

      it 'adds an engagement change if engagement_changes is present' do
        allow(repository_class).to receive(:add).and_return(task)
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
