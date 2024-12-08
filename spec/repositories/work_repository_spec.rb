# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkRepository do
  describe '.by_user_id(user_id)' do
    let(:user) { create(:user) }
    let!(:work) { create(:work, user:) }

    it 'returns not activated wishes only for specific user' do
      expect(described_class.by_user_id(user.id)).to match_array(work)
    end
  end

  describe '.add' do
    let(:user) { create(:user) }
    let(:params) do
      { company_name: 'company name', position_name: 'position name', start_date: Date.current, user_id: user.id }
    end

    it 'creates a wish' do
      expect { described_class.add(**params) }.to change(Work, :count).by(1)
    end
  end

  describe '.update(id, params)' do
    let(:work) { create(:work) }
    let(:params) do
      { company_name: 'Kaseya' }
    end

    it 'updates a work' do
      expect(work.company_name).not_to eq(params[:company_name])
      described_class.update(work.id, **params)
      expect(work.reload.company_name).to eq(params[:company_name])
    end
  end
end
