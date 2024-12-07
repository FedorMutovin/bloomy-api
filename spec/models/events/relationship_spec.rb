# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::Relationship do
  it { is_expected.to belong_to(:triggerable) }
  it { is_expected.to belong_to(:impactable) }
  it { is_expected.to belong_to(:user) }
end
