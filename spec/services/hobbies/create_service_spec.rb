# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hobbies::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { HobbyRepository }
    let(:record_factory) { :hobby }
    let(:attributes) do
      {
        user_id: user.id,
        name: 'hobby name',
        skill_level: 1,
        engagement_level: 2,
        initiated_at: DateTime.current
      }
    end
  end
end
