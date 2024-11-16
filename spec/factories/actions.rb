# frozen_string_literal: true

FactoryBot.define do
  sequence :action_name do |n|
    "action name #{n}"
  end

  sequence :action_description do |n|
    "action description #{n}"
  end
  factory :action do
    name { generate(:action_name) }
    description { generate(:action_description) }
    initiated_at { Time.zone.now }
    user
  end
end
