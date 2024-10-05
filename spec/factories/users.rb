# frozen_string_literal: true

FactoryBot.define do
  sequence :user_email do |n|
    "hi#{n}@example.com"
  end
  factory :user do
    email { generate(:user_email) }
    password { SecureRandom.hex(10) }
  end
end
