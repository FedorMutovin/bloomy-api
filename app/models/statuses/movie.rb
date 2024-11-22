# frozen_string_literal: true

module Statuses
  class Movie
    ALLOWED_STATUSES = [
      Status::WATCHED,
      Status::WAITING
    ].freeze
  end
end
