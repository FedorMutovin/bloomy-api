# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wishes::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { WishRepository }
    let(:record_factory) { :wish }
    let(:attributes) do
      {
        user_id: user.id,
        name: 'wish',
        description: 'wish description',
        priority: 1,
        initiated_at: DateTime.current
      }
    end
  end
end
