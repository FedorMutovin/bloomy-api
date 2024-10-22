# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WishRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:wish) { create(:wish, user:) }

    before { create(:wish) }

    it 'returns wishes only for specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to match_array(wish)
    end
  end
end
