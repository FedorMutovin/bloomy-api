# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkLoad do
  it { is_expected.to belong_to :work }
  it { is_expected.to have_many :work_load_changes }
end
