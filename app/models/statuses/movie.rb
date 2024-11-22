# frozen_string_literal: true

module Statuses
  class Movie
    WATCHED = 'watched'
    WAITING = 'waiting'

    ALLOWED_STATUSES = [
      WATCHED,
      WAITING
    ].freeze
  end
end
