# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Create do
  subject(:service) { described_class.new(params:, user_id:, trigger_params:) }

  let(:user_id) { '1' }
  let(:params) do
    {
      name: 'Practice coding',
      description: 'Solve problems on LeetCode',
      priority: 2,
      initiated_at: Time.zone.now
    }
  end
  let(:trigger_params) { {} }

  describe '#call' do
    let(:task) { build(:task) }

    before do
      allow(TaskRepository).to receive(:add).and_return(task)
    end

    it 'adds user_id to params and creates the task' do
      expected_params = params.deep_dup
      expected_params[:user_id] = user_id

      service.call

      expect(TaskRepository).to have_received(:add).with(params: expected_params)
    end

    context 'when trigger_params is provided' do
      let(:trigger_data) { { 'id' => '51fa64d8-3531-466f-a60f-af64857422d7', 'event_type' => 'Goal' } }
      let(:trigger_params) { trigger_data }
      let(:relationships_create_instance) { instance_double(Events::Relationships::Create) }

      before do
        allow(Events::Relationships::Create).to receive(:new).and_return(relationships_create_instance)
        allow(relationships_create_instance).to receive(:call)
      end

      it 'calls Events::Relationships::Create with correct parameters' do
        service.call

        expect(Events::Relationships::Create).to have_received(:new).with(
          trigger_id: trigger_data['id'],
          trigger_type: trigger_data['event_type'],
          target_id: task.id,
          target_type: 'Task'
        )

        expect(relationships_create_instance).to have_received(:call)
      end
    end

    context 'when trigger_params is empty' do
      let(:trigger_params) { {} }

      before do
        allow(Events::Relationships::Create).to receive(:new)
      end

      it 'does not call Events::Relationships::Create' do
        service.call

        expect(Events::Relationships::Create).not_to have_received(:new)
      end
    end
  end
end
