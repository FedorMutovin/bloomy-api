# frozen_string_literal: true

FactoryBot.define do
  factory :root_unite, class: 'Roots::Unite' do
    target factory: %i[goal]
    source factory: %i[goal]
    reason { 'reason' }
    user
  end
end
