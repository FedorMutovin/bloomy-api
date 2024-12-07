# frozen_string_literal: true

FactoryBot.define do
  factory :root_relationship, class: 'Roots::Relationship' do
    triggerable factory: %i[thought]
    impactable factory: %i[goal]
    user
  end
end
