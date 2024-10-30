# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WishRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:wish) { create(:wish, user:, priority: 0) }

    before { create(:wish) }

    it 'returns wishes only for specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to match_array(wish)
    end

    context 'with priority' do
      let!(:second_wish) { create(:wish, user:, priority: 1) }

      it 'sorted by priority: :asc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(wish)
        expect(result.last).to eq(second_wish)
      end
    end
  end

  describe '.add' do
    let(:user) { create(:user) }
    let(:params) { { title: 'wish title', description: 'wish description' } }

    it 'creates a wish' do
      expect { described_class.add(params:, user_id: user.id) }.to change(Wish, :count).by(1)
    end
  end
end
