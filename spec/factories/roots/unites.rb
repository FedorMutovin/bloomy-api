# frozen_string_literal: true

FactoryBot.define do
  factory :root_unite, class: 'Roots::Unite' do
    target { create(:goal) }
    source { create(:goal) }
    reason { 'reason' }
    user
  end
end
