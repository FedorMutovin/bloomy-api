# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Relationships::Create do
  describe '#call' do
    subject(:service) do
      described_class.new(
        trigger_id:,
        trigger_type:,
        target_id:,
        target_type:
      )
    end

    let(:trigger_id) { '1' }
    let(:trigger_type) { 'Thought' }
    let(:target_id) { '2' }
    let(:target_type) { 'Goal' }

    before do
      allow(Events::RelationshipRepository).to receive(:add)
    end

    it 'calls Events::RelationshipRepository.add with correct params' do
      service.call

      expect(Events::RelationshipRepository).to have_received(:add).with(
        trigger_id:,
        trigger_type:,
        target_id:,
        target_type:
      )
    end
  end
end
