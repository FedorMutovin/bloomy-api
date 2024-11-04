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
  end
end
