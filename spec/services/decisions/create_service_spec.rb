# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Decisions::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { DecisionRepository }
    let(:record_factory) { :decision }
    let(:attributes) do
      {
        user_id: user.id,
        name: 'decision name',
        description: 'decision description',
        initiated_at: DateTime.current
      }
    end
  end
end
