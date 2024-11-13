# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActionRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:action) { create(:action, user:) }
    let!(:other_user_action) { create(:action) }

    it 'returns only actions for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(action)
    end

    it 'does not return actions of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_action)
    end

    context 'with initiated at ordering' do
      let!(:old_action) { create(:action, user:, initiated_at: DateTime.current - 1.year) }

      it 'sorted by initiated_at: :desc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(action)
        expect(result.last).to eq(old_action)
      end
    end
  end

  describe '.add(**params)' do
    let(:user) { create(:user) }
    let(:params) do
      { name: 'action name', description: 'action description', user_id: user.id, initiated_at: Time.zone.now }
    end

    it 'creates an action' do
      expect { described_class.add(**params) }.to change(Action, :count).by(1)
    end
  end
end
