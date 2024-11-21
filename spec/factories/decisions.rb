# frozen_string_literal: true

FactoryBot.define do
  sequence :decision_name do |n|
    "decision name #{n}"
  end

  sequence :decision_description do |n|
    "decision description #{n}"
  end
  factory :decision do
    name { generate(:decision_name) }
    description { generate(:decision_description) }
    initiated_at { Time.zone.now }
    user
  end
end
