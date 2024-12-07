# frozen_string_literal: true

class MovieSerializer < Panko::Serializer
  attributes :id, :name, :status, :rating, :completed_at, :initiated_at

  def completed_at
    object.completed_at&.utc&.iso8601
  end

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end
end
