# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRepository do
  describe '.by_id(id:)' do
    let(:user) { create(:user) }

    it 'returns all goals' do
      expect(described_class.by_id(id: user.id)).to eq(user)
    end
  end
end
