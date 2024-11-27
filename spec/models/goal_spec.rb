# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_one :engagement }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of(:initiated_at) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(Statuses::Goal::ALLOWED_STATUSES) }
  it { is_expected.to validate_numericality_of(:priority).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:priority).is_less_than_or_equal_to(4) }

  it_behaves_like 'relatable'
  it_behaves_like 'unitable'
end
