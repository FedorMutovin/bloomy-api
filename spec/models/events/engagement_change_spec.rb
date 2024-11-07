# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::EngagementChange do
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:reason) }
  it { is_expected.to belong_to(:target) }
end
