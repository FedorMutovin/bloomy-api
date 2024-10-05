# frozen_string_literal: true

RSpec.shared_examples 'relatable' do
  it { is_expected.to have_many(:triggers).class_name('EventRelationship') }
  it { is_expected.to have_many(:impacts).class_name('EventRelationship') }
end
