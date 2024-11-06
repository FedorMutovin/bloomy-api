# frozen_string_literal: true

FactoryBot.define do
  factory :event_relationship, class: 'Events::Relationship' do
    triggerable factory: %i[thought]
    impactable factory: %i[goal]
  end
end
