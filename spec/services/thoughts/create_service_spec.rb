# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thoughts::CreateService, type: :service do
  it_behaves_like 'Roots::CreateService' do
    let(:repository_class) { ThoughtRepository }
    let(:record_factory) { :thought }
    let(:attributes) do
      {
        user_id: user.id,
        description: 'Thought description',
        initiated_at: DateTime.current
      }
    end
  end
end
