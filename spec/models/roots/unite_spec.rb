# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Roots::Unite do
  it { is_expected.to belong_to(:source) }
  it { is_expected.to belong_to(:target) }
  it { is_expected.to belong_to(:user) }
end
