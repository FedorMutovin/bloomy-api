# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hobby do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:initiated_at) }
  it { is_expected.to validate_numericality_of(:skill_level).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:skill_level).is_less_than_or_equal_to(4) }
  it { is_expected.to validate_numericality_of(:engagement_level).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:engagement_level).is_less_than_or_equal_to(4) }

  it_behaves_like 'relatable'
end
