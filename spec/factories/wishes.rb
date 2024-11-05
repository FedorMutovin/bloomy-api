# frozen_string_literal: true

FactoryBot.define do
  sequence :wish_name do |n|
    "wish name #{n}"
  end

  sequence :wish_description do |n|
    "wish description #{n}"
  end
  factory :wish do
    name { generate(:wish_name) }
    description { generate(:wish_description) }
    initiated_at { Time.zone.now }
    user
  end
end
