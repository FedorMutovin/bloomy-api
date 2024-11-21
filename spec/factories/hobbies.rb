# frozen_string_literal: true

FactoryBot.define do
  sequence :hobby_name do |n|
    "hobby name #{n}"
  end

  factory :hobby do
    name { generate(:hobby_name) }
    initiated_at { Time.zone.now }
    skill_level { rand(0..4) }
    engagement_level { rand(0..4) }
    user
  end
end
