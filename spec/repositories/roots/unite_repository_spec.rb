# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::UniteRepository do
  describe '.unite(**params)' do
    let(:user) { create(:user) }
    let(:goal_to_unite) { create(:goal, user:) }
    let(:goal) { create(:goal, user:) }
    let(:params) do
      {
        source_id: goal_to_unite.id,
        source_type: goal_to_unite.class.name,
        target_id: goal.id,
        target_type: goal.class.name,
        user_id: user.id,
        reason: 'reason'
      }
    end

    it 'creates an Roots::Unite' do
      expect { described_class.unite(**params) }.to change(Roots::Unite, :count).by(1)
    end
  end
end
