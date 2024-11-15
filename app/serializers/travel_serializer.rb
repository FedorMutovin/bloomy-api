# frozen_string_literal: true

class TravelSerializer < Panko::Serializer
  attributes :id, :description, :destination, :initiated_at, :start_at, :end_at

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end

  def start_at
    object.start_at&.utc&.iso8601
  end

  def end_at
    object.end_at&.utc&.iso8601
  end
end
