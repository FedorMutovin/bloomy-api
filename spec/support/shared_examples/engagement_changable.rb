# frozen_string_literal: true

RSpec.shared_examples 'engagement_changable' do
  it { is_expected.to have_many(:engagement_changes).class_name('Events::EngagementChange') }
end
