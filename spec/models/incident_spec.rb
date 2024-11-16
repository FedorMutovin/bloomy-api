# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Incident do
  it { is_expected.to belong_to :user }

  it_behaves_like 'relatable'
end
