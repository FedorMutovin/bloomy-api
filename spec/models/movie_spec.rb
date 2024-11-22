# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(Statuses::Movie::ALLOWED_STATUSES) }
  it { is_expected.to validate_inclusion_of(:rating).in_array(described_class::ALLOWED_RATINGS) }
  it { is_expected.to allow_value(nil).for(:rating) }

  it_behaves_like 'relatable'
  it_behaves_like 'reflectable'
end
