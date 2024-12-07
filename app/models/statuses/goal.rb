# frozen_string_literal: true

module Statuses
  class Goal
    DEFAULT = Status::PENDING

    ALLOWED_FOR_CREATE = [
      Status::IN_PROGRESS
    ].freeze

    ALLOWED_FOR_UPDATE = [
      Status::UNITED
    ].freeze
  end
end
