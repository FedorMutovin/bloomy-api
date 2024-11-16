# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_one :work_load }
end
