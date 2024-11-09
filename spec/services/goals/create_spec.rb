# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goals::Create do
  subject(:service) { described_class.new(params:, user_id:, trigger_params:) }

  let(:user_id) { '1' }
  let(:trigger_params) { {} }
  let(:params) do
    {
      name: 'Learn Ruby',
      description: 'Master the Ruby programming language',
      priority: 2,
      initiated_at: Time.zone.now,
      tasks_attributes: [
        { name: 'Read a book', description: 'Read "Programming Ruby"', priority: 1, initiated_at: Time.zone.now },
        { name: 'Practice coding', description: 'Solve problems on LeetCode', priority: 2, initiated_at: Time.zone.now }
      ]
    }
  end

  describe '#call' do
    let(:goal) { build(:goal) }

    before do
      allow(GoalRepository).to receive(:add).and_return(goal)
    end

    it 'adds user_id to params and creates the goal' do
      expected_params = params.deep_dup
      expected_params[:user_id] = user_id
      expected_params[:tasks_attributes].each { |task| task.merge!(user_id:) }

      service.call

      expect(GoalRepository).to have_received(:add).with(params: expected_params)
    end

    context 'when tasks_attributes is nil' do
      let(:params) do
        {
          name: 'Learn Ruby',
          description: 'Master the Ruby programming language',
          priority: 2,
          initiated_at: Time.zone.now
        }
      end

      it 'does not raise an error and adds user_id to params' do
        expected_params = params.deep_dup
        expected_params[:user_id] = user_id

        expect { service.call }.not_to raise_error

        expect(GoalRepository).to have_received(:add).with(params: expected_params)
      end
    end

    context 'when trigger_params is present' do
      let(:trigger_params) { { 'id' => '51fa64d8-3531-466f-a60f-af64857422d7', 'event_type' => 'Goal' } }
      let(:relationships_create_instance) { instance_double(Events::Relationships::Create) }

      before do
        allow(Events::Relationships::Create).to receive(:new).and_return(relationships_create_instance)
        allow(relationships_create_instance).to receive(:call)
      end

      it 'calls Events::Relationships::Create with correct parameters' do
        service.call

        expect(Events::Relationships::Create).to have_received(:new).with(
          trigger_id: trigger_params['id'],
          trigger_type: trigger_params['event_type'],
          target_id: goal.id,
          target_type: 'Goal'
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
