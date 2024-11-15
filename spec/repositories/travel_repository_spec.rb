# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TravelRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:travel) { create(:travel, user:) }
    let!(:other_user_travel) { create(:travel) }

    it 'returns only travels for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(travel)
    end

    it 'does not return travels of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_travel)
    end

    context 'with initiated at ordering' do
      let!(:old_travel) { create(:travel, user:, initiated_at: DateTime.current - 1.year) }

      it 'sorted by initiated_at: :desc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(travel)
        expect(result.last).to eq(old_travel)
      end
    end
  end
end
