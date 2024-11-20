# frozen_string_literal: true

module Statuses
  class Task
    ALLOWED_STATUSES = [
      Status::IN_PROGRESS,
      Status::PENDING,
      Status::COMPLETED,
      Status::CANCELED,
      Status::POSTPONED,
      Status::SCHEDULED
    ].freeze

    DEFAULT = Status::PENDING

    ALLOWED_FOR_CREATE = [
      Status::IN_PROGRESS,
      Status::SCHEDULED,
      Status::PENDING
    ].freeze
  end
end
