# frozen_string_literal: true

RSpec.shared_examples 'reflectable' do
  it { is_expected.to have_many(:reflections).class_name('Event::Reflection') }
end
