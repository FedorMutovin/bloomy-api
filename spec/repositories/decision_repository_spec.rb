# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DecisionRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:decision) { create(:decision, user:) }
    let!(:other_user_decision) { create(:decision) }

    it 'returns only decisions for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(decision)
    end

    it 'does not return decisions of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_decision)
    end

    context 'with initiated at ordering' do
      let!(:old_decision) { create(:decision, user:, initiated_at: DateTime.current - 1.year) }

      it 'sorted by initiated_at: :desc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(decision)
        expect(result.last).to eq(old_decision)
      end
    end
  end

  describe '.add(**params)' do
    let(:user) { create(:user) }
    let(:params) do
      { name: 'decision name', description: 'decision description', user_id: user.id,
        initiated_at: Time.zone.now }
    end

    it 'creates a decision' do
      expect { described_class.add(**params) }.to change(Decision, :count).by(1)
    end
  end
end
