# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Unpostpone do
  let(:service) { described_class.new }
  let!(:postponed_task) do
    build_stubbed(:task, postponed_at: 1.day.ago, postponed_until: 1.day.ago, status: Status::IN_PROGRESS)
  end
  let(:default_params) do
    {
      postponed_at: nil,
      postponed_until: nil,
      status: Status::PENDING
    }
  end

  before do
    allow(TaskRepository).to receive(:ready_to_postpone).and_return([postponed_task])
    allow(TaskRepository).to receive(:update).with(postponed_task, default_params)
  end

  describe '#call' do
    it 'sets default params correctly' do
      service.call

      expect(TaskRepository).to have_received(:ready_to_postpone)
      expect(TaskRepository).to have_received(:update).with(postponed_task, default_params)
    end
  end
end
