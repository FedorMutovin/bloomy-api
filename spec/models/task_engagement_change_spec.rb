# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskEngagementChange do
  it { is_expected.to belong_to :engagement }
end
