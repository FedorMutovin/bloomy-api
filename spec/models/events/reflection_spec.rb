# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Reflection do
  it { is_expected.to validate_presence_of(:description) }
end
