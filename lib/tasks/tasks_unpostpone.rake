# frozen_string_literal: true

namespace :tasks do
  desc 'Unpostpone tasks where postponed_until is current datetime'
  task unpostpone: :environment do
    Tasks::UnpostponeService.call
  end
end
