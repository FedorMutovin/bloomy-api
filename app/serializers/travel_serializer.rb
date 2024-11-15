# frozen_string_literal: true

class TravelSerializer < Panko::Serializer
  attributes :id, :description, :destination, :initiated_at

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end
end
