# frozen_string_literal: true

class GoalSerializer < Panko::Serializer
  attributes :id, :name, :description, :initiated_at, :status, :started_at, :closed_at, :priority

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end

  def started_at
    object.started_at&.utc&.iso8601
  end
end
