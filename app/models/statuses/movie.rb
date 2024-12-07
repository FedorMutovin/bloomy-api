# frozen_string_literal: true

module Statuses
  class Movie
    WATCHED = 'watched'
    WAITING = 'waiting'

    ALLOWED_FOR_CREATE = [
      WATCHED,
      WAITING
    ].freeze
  end
end
