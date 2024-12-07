# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Travels::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { TravelRepository }
    let(:record_factory) { :travel }
    let(:attributes) do
      {
        user_id: user.id,
        destination: 'travel destination',
        description: 'travel description',
        initiated_at: DateTime.current,
        start_at: DateTime.current - 1.hour,
        end_at: DateTime.current + 10.hours
      }
    end
  end
end
