# frozen_string_literal: true

FactoryBot.define do
  factory :work_load do
    value { WorkLoad::MAX_LOAD_VALUE }
    work
  end
end
