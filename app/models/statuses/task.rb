# frozen_string_literal: true

module Statuses
  class Task
    DEFAULT = Status::PENDING

    ALLOWED_FOR_CREATE = [
      Status::IN_PROGRESS,
      Status::SCHEDULED,
      Status::PENDING
    ].freeze

    ALLOWED_FOR_UPDATE = [
      Status::IN_PROGRESS,
      Status::SCHEDULED,
      Status::PENDING
    ].freeze
  end
end
