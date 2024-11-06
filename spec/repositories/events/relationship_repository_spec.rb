# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::RelationshipRepository do
  describe '.add(trigger:, target:)' do
    let(:user) { create(:user) }
    let!(:trigger) { create(:thought, user:) }
    let!(:target) { create(:goal, user:) }

    it 'creates a Events::Relationship' do
      expect do
        described_class.add(
          trigger_id: trigger.id,
          trigger_type: trigger.class.name,
          target_id: target.id,
          target_type: target.class.name
        )
      end.to change(Events::Relationship, :count).by(1)
    end
  end

  describe '.find_trigger_by_id(trigger_id:)' do
    let(:user) { create(:user) }
    let(:trigger) { create(:thought, user:) }
    let(:target) { create(:task, user:) }
    let!(:event_relationship) { create(:event_relationship, triggerable: trigger, impactable: target) }

    it 'finds trigger by trigger_id' do
      expect(described_class.find_trigger_by_id(trigger_id: trigger.id)).to eq(trigger)
    end
  end
end
