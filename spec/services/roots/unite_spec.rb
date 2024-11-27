# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::UniteService, type: :service do
  subject(:service_call) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:params) do
    {
      user_id: user.id,
      source: {
        id: 'id 1',
        event_type: 'Goal'
      },
      target: {
        id: 'id 2',
        event_type: 'Goal'
      },
      reason: 'reason'
    }
  end

  let(:attributes) do
    {
      source_id: params[:source][:id],
      source_type: params[:source][:event_type],
      target_id: params[:target][:id],
      target_type: params[:target][:event_type],
      user_id: params[:user_id],
      reason: params[:reason]
    }
  end

  describe '#call' do
    context 'when uniting roots' do
      it 'unites roots with specified attributes' do
        allow(Roots::UniteRepository).to receive(:unite)
        service_call
        expect(Roots::UniteRepository).to have_received(:unite).with(attributes)
      end
    end
  end
end
