# frozen_string_literal: true

FactoryBot.define do
  sequence :task_name do |n|
    "task name #{n}"
  end

  sequence :task_description do |n|
    "task description #{n}"
  end
  factory :task do
    name { generate(:task_name) }
    description { generate(:task_description) }
    user
  end
end
