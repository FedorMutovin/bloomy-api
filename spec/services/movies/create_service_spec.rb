# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { MovieRepository }
    let(:record_factory) { :movie }
    let(:attributes) do
      {
        user_id: user.id,
        name: 'movie name',
        status: 'watched',
        rating: 'interesting',
        completed_at: DateTime.current
      }
    end
  end
end
