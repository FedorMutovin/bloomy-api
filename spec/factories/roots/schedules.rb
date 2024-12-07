# frozen_string_literal: true

FactoryBot.define do
  factory :root_schedule, class: 'Roots::Schedule' do
    scheduled_at { 10.days.from_now }
    completed { false }
    user
    trait :travel do
      scheduable factory: %i[travel]
      details { { destination: scheduable.destination } }
    end
  end
end
