# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HobbyRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:hobby) { create(:hobby, user:) }
    let!(:other_user_hobby) { create(:hobby) }

    it 'returns only hobbies for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(hobby)
    end

    it 'does not return hobbies of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_hobby)
    end

    context 'with initiated at ordering' do
      let!(:old_hobby) { create(:hobby, user:, initiated_at: DateTime.current - 1.year) }

      it 'sorted by initiated_at: :desc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(hobby)
        expect(result.last).to eq(old_hobby)
      end
    end
  end

  describe '.add(**params)' do
    let(:user) { create(:user) }
    let(:params) do
      { name: 'hobby name', skill_level: 2, engagement_level: 1, user_id: user.id,
        initiated_at: Time.zone.now }
    end

    it 'creates a decision' do
      expect { described_class.add(**params) }.to change(Hobby, :count).by(1)
    end
  end
end
