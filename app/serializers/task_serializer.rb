# frozen_string_literal: true

class TaskSerializer < Panko::Serializer
  attributes :id, :name, :description, :status, :priority, :initiated_at, :started_at

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end

  def started_at
    object.started_at&.utc&.iso8601
  end
end
