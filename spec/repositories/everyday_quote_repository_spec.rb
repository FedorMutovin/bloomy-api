# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EverydayQuoteRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:everyday_quote) { create(:everyday_quote, user:) }

    before { create(:everyday_quote) }

    it 'returns only events for the specific user' do
      expect(described_class.by_user_id(user.id)).to contain_exactly(everyday_quote)
    end
  end
end
