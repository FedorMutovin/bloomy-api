# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goals::Create do
  subject(:service) { described_class.new(params, user_id:) }

  let(:user_id) { '1' }
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
    before do
      allow(GoalRepository).to receive(:add)
      allow(Events::RelationshipRepository).to receive(:add) # Добавляем здесь, чтобы метод стал шпионом
    end

    it 'adds user_id to params' do
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

      it 'does not raise error and adds user_id to params' do
        expected_params = params.deep_dup
        expected_params[:user_id] = user_id

        expect { service.call }.not_to raise_error

        expect(GoalRepository).to have_received(:add).with(params: expected_params)
      end
    end

    context 'when triggers_attributes is present' do
      let(:trigger_data) { { 'id' => '51fa64d8-3531-466f-a60f-af64857422d7', 'event_type' => 'Goal' } }
      let(:goal) { double('goal', id: 'goal-id', class: double(name: 'Goal')) }
      let(:params) do
        super().merge(triggers_attributes: [trigger_data])
      end

      before do
        allow(GoalRepository).to receive(:add).and_return(goal)
      end

      it 'links the trigger event to the created goal' do
        service.call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          trigger_id: trigger_data['id'],
          trigger_type: trigger_data['event_type'],
          target_id: goal.id,
          target_type: 'Goal'
        )
      end
    end

    context 'when triggers_attributes is not present' do
      it 'does not call add on Events::RelationshipRepository' do
        service.call

        expect(Events::RelationshipRepository).not_to have_received(:add)
      end
    end
  end
end
