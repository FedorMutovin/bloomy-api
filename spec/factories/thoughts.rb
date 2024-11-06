# frozen_string_literal: true

FactoryBot.define do
  sequence :thought_description do |n|
    "thought name #{n}"
  end
  factory :thought do
    description { generate(:thought_description) }
    user
    initiated_at { Time.zone.now }
  end
end
