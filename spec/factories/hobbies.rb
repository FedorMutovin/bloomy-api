# frozen_string_literal: true

FactoryBot.define do
  sequence :hobby_name do |n|
    "hobby name #{n}"
  end

  factory :hobby do
    name { generate(:hobby_name) }
    initiated_at { Time.zone.now }
    skill_level { rand(Hobby::MIN_LEVEL..Hobby::MAX_LEVEL).to_i }
    engagement_level { rand(Hobby::MIN_ENGAGEMENT_LEVEL..Hobby::MAX_ENGAGEMENT_LEVEL).to_i }
    user
  end
end
