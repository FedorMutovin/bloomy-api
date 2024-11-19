# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ThoughtRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:thought) { create(:thought, user:) }
    let!(:other_user_thought) { create(:thought) }

    it 'returns only thoughts for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(thought)
    end

    it 'does not return thoughts of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_thought)
    end

    context 'with initiated at ordering' do
      let!(:old_thought) { create(:thought, user:, initiated_at: DateTime.current - 1.year) }

      it 'sorted by initiated_at: :desc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(thought)
        expect(result.last).to eq(old_thought)
      end
    end
  end

  describe '.add(**params)' do
    let(:user) { create(:user) }
    let(:params) do
      { description: 'thought description', user_id: user.id, initiated_at: Time.zone.now }
    end

    it 'creates a travel' do
      expect { described_class.add(**params) }.to change(Thought, :count).by(1)
    end
  end
end
