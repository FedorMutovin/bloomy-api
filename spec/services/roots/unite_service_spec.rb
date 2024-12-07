# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::UniteService, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user_id) { 'user-id' }
  let(:source_id) { 'source-id' }
  let(:target_id) { 'target-id' }
  let(:reason) { 'Some reason' }
  let(:source_event_type) { 'Goal' }
  let(:target_event_type) { 'Task' }

  let(:params) do
    {
      user_id:,
      source: { id: source_id, event_type: source_event_type },
      target: { id: target_id, event_type: target_event_type },
      reason:
    }
  end

  # Mocks for repositories
  let(:unite_repository) { class_double(Roots::UniteRepository) }
  let(:source_repository_class) { class_double("#{source_event_type}Repository") }

  before do
    stub_const('Roots::UniteRepository', unite_repository)
    stub_const("#{source_event_type}Repository", source_repository_class)

    allow(unite_repository).to receive(:unite)
    allow(source_repository_class).to receive(:update)
  end

  describe '#call' do
    it 'performs unite_roots! and update_source_root_status within a transaction' do
      allow(ActiveRecord::Base).to receive(:transaction).and_yield

      service_call

      expect(ActiveRecord::Base).to have_received(:transaction)
      expect(unite_repository).to have_received(:unite).with(
        source_id:,
        source_type: source_event_type,
        target_id:,
        target_type: target_event_type,
        user_id:,
        reason:
      )

      expect(source_repository_class).to have_received(:update).with(
        source_id,
        status: Status::UNITED
      )
    end

    it 'determines the source repository based on event_type' do
      service_call

      expect(source_repository_class).to have_received(:update)
    end

    context 'when an error occurs during unite_roots!' do
      before do
        allow(unite_repository).to receive(:unite).and_raise(StandardError, 'Test error')
      end

      it 'does not update the source root status and raises an error' do
        expect { service_call }.to raise_error(StandardError, 'Test error')

        expect(source_repository_class).not_to have_received(:update)
      end
    end
  end

  context 'with different source event types' do
    RootRepository.available_types.each do |event_type|
      context "when source event_type is #{event_type}" do
        let(:source_event_type) { event_type }
        let(:source_repository_class) { class_double("#{event_type}Repository") }

        before do
          stub_const("#{event_type}Repository", source_repository_class)
          allow(source_repository_class).to receive(:update)
        end

        it "uses #{event_type}Repository to update the source root status" do
          service_call

          expect(source_repository_class).to have_received(:update).with(
            source_id,
            status: Status::UNITED
          )
        end
      end
    end
  end
end
