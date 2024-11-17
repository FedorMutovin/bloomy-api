# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskEngagement do
  it { is_expected.to belong_to :task }
  it { is_expected.to have_many :engagement_changes }
end
