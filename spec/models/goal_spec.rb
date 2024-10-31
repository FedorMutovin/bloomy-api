# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal do
  it { is_expected.to have_many :actions }
  it { is_expected.to have_many :tasks }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of(:initiated_at) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(described_class::ALLOWED_STATUSES) }
  it { is_expected.to validate_numericality_of(:priority).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:priority).is_less_than_or_equal_to(4) }

  it_behaves_like 'relatable'
end
