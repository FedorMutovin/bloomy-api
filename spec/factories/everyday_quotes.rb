# frozen_string_literal: true

FactoryBot.define do
  sequence :everyday_quote_description do |n|
    "everyday quote description #{n}"
  end
  factory :everyday_quote do
    description { generate(:everyday_quote_description) }
    user
  end
end
