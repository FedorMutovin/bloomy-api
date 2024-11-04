# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thought do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:initiated_at) }

  it_behaves_like 'relatable'
  it_behaves_like 'reflectable'
end
