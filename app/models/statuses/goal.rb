# frozen_string_literal: true

module Statuses
  class Goal
    ALLOWED_STATUSES = [
      Status::IN_PROGRESS,
      Status::PENDING,
      Status::COMPLETED,
      Status::CANCELED,
      Status::POSTPONED
    ].freeze

    DEFAULT = Status::PENDING

    ALLOWED_FOR_CREATE = [
      Status::IN_PROGRESS
    ].freeze
  end
end
