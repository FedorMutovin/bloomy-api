# frozen_string_literal: true

FactoryBot.define do
  sequence :work_company_name do |n|
    "action name #{n}"
  end

  sequence :work_position_name do |n|
    "action description #{n}"
  end
  factory :work do
    company_name { generate(:work_company_name) }
    position_name { generate(:work_position_name) }
    start_date { Date.current }
    user
  end
end
