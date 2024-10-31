# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Travel do
  it { is_expected.to belong_to(:vacation).optional }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_presence_of(:initiated_at) }

  it_behaves_like 'relatable'
  it_behaves_like 'scheduable'
end
