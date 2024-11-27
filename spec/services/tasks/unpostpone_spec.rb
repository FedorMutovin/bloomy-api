# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Unpostpone do
  let(:service) { described_class.new }
  let!(:postponed_task) do
    create(:task, postponed_at: 1.day.ago, postponed_until: 1.day.ago, status: Status::IN_PROGRESS)
  end
  let(:default_params) do
    {
      postponed_at: nil,
      postponed_until: nil,
      status: Status::PENDING
    }
  end

  before do
    allow(TaskRepository).to receive(:postponed_tasks).and_return([postponed_task])
    allow(TaskRepository).to receive(:update_tasks).with([postponed_task], default_params).and_call_original
  end

  describe '#call' do
    it 'sets default params correctly' do
      service.call

      updated_task = postponed_task.reload
      expect(updated_task.postponed_at).to be_nil
      expect(updated_task.postponed_until).to be_nil
      expect(updated_task.status).to eq(Status::PENDING)

      expect(TaskRepository).to have_received(:update_tasks).with([postponed_task], default_params)
    end
  end
end
