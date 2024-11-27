# frozen_string_literal: true

RSpec.shared_examples 'unitable' do
  it { is_expected.to have_one(:unite_root).class_name('Roots::Unite') }
  it { is_expected.to have_many(:unites).class_name('Roots::Unite') }
end
