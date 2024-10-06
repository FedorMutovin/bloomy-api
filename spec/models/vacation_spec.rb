# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vacation do
  it { is_expected.to have_many :travels }
  it { is_expected.to belong_to :user }

  it_behaves_like 'relatable'
  it_behaves_like 'scheduable'
end
