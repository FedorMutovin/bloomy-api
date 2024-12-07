# frozen_string_literal: true

RSpec.shared_examples 'relatable' do
  it { is_expected.to have_many(:triggers).class_name('Roots::Relationship') }
  it { is_expected.to have_many(:impacts).class_name('Roots::Relationship') }
end
