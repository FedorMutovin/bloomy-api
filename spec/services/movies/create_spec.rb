# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::Create, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:attributes) do
    {
      user_id: user.id,
      name: 'movie name',
      status: 'watched',
      rating: 'interesting',
      completed_at: DateTime.current
    }
  end

  let(:params) { attributes }

  describe '#call' do
    context 'when creating a movie' do
      it 'creates a new movie with the specified attributes' do
        allow(MovieRepository).to receive(:add)
        service_call
        expect(MovieRepository).to have_received(:add).with(attributes)
      end
    end

    context 'when adding an event relationship' do
      let(:trigger_params) do
        { trigger: { id: 'wish-id', event_type: 'Wish' } }
      end
      let(:params) { attributes.merge(trigger_params) }
      let(:movie) do
        build_stubbed(:movie, user:, name: 'movie name', status: 'watched', rating: 'interesting',
                              completed_at: DateTime.current)
      end

      it 'adds an event relationship if trigger is present' do
        allow(MovieRepository).to receive(:add).and_return(movie)
        allow(Events::RelationshipRepository).to receive(:add)

        service_call

        expect(Events::RelationshipRepository).to have_received(:add).with(
          triggerable_id: params[:trigger][:id],
          triggerable_type: params[:trigger][:event_type],
          impactable_id: movie.id,
          impactable_type: movie.class.name
        )
      end
    end
  end
end
