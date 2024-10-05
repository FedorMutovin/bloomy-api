# frozen_string_literal: true

FactoryBot.define do
  sequence :goal_name do |n|
    "goal name #{n}"
  end
  factory :goal do
    name { generate(:goal_name) }
    user
  end
end
