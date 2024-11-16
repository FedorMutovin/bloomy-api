# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkLoadChange do
  it { is_expected.to belong_to :work_load }
end
