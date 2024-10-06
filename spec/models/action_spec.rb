# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Action do
  it { is_expected.to belong_to(:task).optional }
  it { is_expected.to belong_to(:goal).optional }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:title) }

  it_behaves_like 'relatable'
end
