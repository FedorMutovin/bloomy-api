# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_one :engagement }

  it_behaves_like 'relatable'
  it_behaves_like 'scheduable'
  it_behaves_like 'reflectable'
end
