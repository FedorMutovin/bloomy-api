# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task do
  it { is_expected.to have_many :actions }
  it { is_expected.to belong_to(:goal).optional }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(described_class::ALLOWED_STATUSES) }

  it_behaves_like 'relatable'
  it_behaves_like 'scheduable'
  it_behaves_like 'reflectable'
end