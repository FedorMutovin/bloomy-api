# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interest do
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:name) }

  it_behaves_like 'relatable'
end
