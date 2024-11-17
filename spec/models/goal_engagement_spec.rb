# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoalEngagement do
  it { is_expected.to belong_to :goal }
  it { is_expected.to have_many :engagement_changes }
end
