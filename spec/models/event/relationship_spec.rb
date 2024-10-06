# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event::Relationship do
  it { is_expected.to belong_to(:triggerable) }
  it { is_expected.to belong_to(:impactable) }
  it { is_expected.to validate_presence_of(:relation_type) }
  it { is_expected.to validate_inclusion_of(:relation_type).in_array(described_class::ALLOWED_RELATION_TYPES) }
end
