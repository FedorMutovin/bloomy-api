# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:task) { create(:task, user:) }

    before { create(:task) }

    it 'returns wishes only for specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to match_array(task)
    end
  end
end
