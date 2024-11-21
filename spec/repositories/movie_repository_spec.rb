# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MovieRepository do
  describe '.by_user_id(user_id:)' do
    let(:user) { create(:user) }
    let!(:movie) { create(:movie, user:) }
    let!(:other_user_movie) { create(:movie) }

    it 'returns only movies for the specific user' do
      expect(described_class.by_user_id(user_id: user.id)).to contain_exactly(movie)
    end

    it 'does not return movies of other users' do
      result = described_class.by_user_id(user_id: user.id)
      expect(result).not_to include(other_user_movie)
    end

    context 'with created at ordering' do
      let!(:old_movie) { create(:movie, user:, created_at: DateTime.current - 1.year) }

      it 'sorted by created_at: :desc' do
        result = described_class.by_user_id(user_id: user.id)
        expect(result.first).to eq(movie)
        expect(result.last).to eq(old_movie)
      end
    end
  end

  describe '.add(**params)' do
    let(:user) { create(:user) }
    let(:params) do
      { name: 'movie name', status: 'waiting', rating: 'neutral', user_id: user.id, created_at: Time.zone.now }
    end

    it 'creates a movie' do
      expect { described_class.add(**params) }.to change(Movie, :count).by(1)
    end
  end
end
