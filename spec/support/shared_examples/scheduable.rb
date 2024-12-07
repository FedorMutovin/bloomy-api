# frozen_string_literal: true

RSpec.shared_examples 'scheduable' do
  it { is_expected.to have_one(:schedule).class_name('Roots::Schedule') }
end
