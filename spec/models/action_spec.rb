# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Action do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:initiated_at) }

  it_behaves_like 'relatable'
  it_behaves_like 'reflectable'
end
