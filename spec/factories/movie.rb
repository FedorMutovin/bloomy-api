# frozen_string_literal: true

FactoryBot.define do
  sequence :movie_name do |n|
    "movie name #{n}"
  end

  factory :movie do
    name { generate(:movie_name) }
    status { 'watched' }
    rating { 'interesting' }
    user
  end
end
