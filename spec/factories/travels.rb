# frozen_string_literal: true

FactoryBot.define do
  sequence :travel_destination do |n|
    "travel destination #{n}"
  end

  sequence :travel_description do |n|
    "travel description #{n}"
  end
  factory :travel do
    destination { generate(:travel_destination) }
    description { generate(:travel_description) }
    initiated_at { Time.zone.now }
    start_at { 1.day.from_now }
    end_at { start_at + 2.days }
    user
  end
end
