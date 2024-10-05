# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_many :goals }
  it { is_expected.to validate_presence_of :email }

  describe 'validate email uniqueness' do
    before { create(:user) }

    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
