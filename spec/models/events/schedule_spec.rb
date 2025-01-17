# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Schedule do
  it { is_expected.to belong_to(:scheduable) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:scheduled_at) }
end
