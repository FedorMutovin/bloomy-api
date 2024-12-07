# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::RelationshipRepository do
  describe '.add(**params)' do
    let(:user) { create(:user) }
    let!(:triggerable) { create(:thought, user:) }
    let!(:impactable) { create(:goal, user:) }

    it 'creates a Roots::Relationship' do
      expect do
        described_class.add(
          triggerable_id: triggerable.id,
          triggerable_type: triggerable.class.name,
          impactable_id: impactable.id,
          impactable_type: impactable.class.name,
          user_id: user.id
        )
      end.to change(Roots::Relationship, :count).by(1)
    end
  end

  describe '.find_trigger_by_id(trigger_id:)' do
    let(:user) { create(:user) }
    let(:trigger) { create(:thought, user:) }
    let(:target) { create(:task, user:) }

    before { create(:root_relationship, triggerable: trigger, impactable: target) }

    it 'finds trigger by trigger_id' do
      expect(described_class.find_trigger_by_id(trigger_id: trigger.id)).to eq(trigger)
    end
  end

  describe '.by_user_id(user_id)' do
    let(:user) { create(:user) }
    let!(:relationship) { create(:root_relationship, user:) }

    before { create(:root_relationship) }

    it 'returns relationships only for the specific user' do
      expect(described_class.by_user_id(user.id)).to contain_exactly(relationship)
    end
  end
end
