# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Actions::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { ActionRepository }
    let(:record_factory) { :action }
    let(:attributes) do
      {
        user_id: user.id,
        name: 'action',
        description: 'action description',
        initiated_at: DateTime.current
      }
    end
  end
end
