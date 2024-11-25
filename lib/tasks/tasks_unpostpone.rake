# frozen_string_literal: true

namespace :tasks do
  desc 'Unpostpone tasks where postpone_until is within the next 5 minutes'
  task unpostpone: :environment do
    TaskRepository.unpostpone_tasks
  end
end
