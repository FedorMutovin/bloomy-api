# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Goal do
  it { is_expected.to have_many :actions }
  it { is_expected.to have_many :tasks }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :name }

  it_behaves_like 'relatable'
end
