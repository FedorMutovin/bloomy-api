# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_many :goals }
  it { is_expected.to have_many :actions }
  it { is_expected.to have_many :decisions }
  it { is_expected.to have_many :hobbies }
  it { is_expected.to have_many :thoughts }
  it { is_expected.to have_many :schedules }
  it { is_expected.to have_many :interests }
  it { is_expected.to have_many :movies }
  it { is_expected.to have_many :activities }
  it { is_expected.to have_many :wishes }
  it { is_expected.to have_many :independent_events }
  it { is_expected.to have_many :works }
  it { is_expected.to validate_presence_of :email }

  describe 'validate email uniqueness' do
    before { create(:user) }

    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
