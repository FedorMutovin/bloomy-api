# frozen_string_literal: true

FactoryBot.define do
  sequence :wish_title do |n|
    "wish title #{n}"
  end

  sequence :wish_description do |n|
    "wish description #{n}"
  end
  factory :wish do
    title { generate(:wish_title) }
    description { generate(:wish_description) }
    user
  end
end
