# frozen_string_literal: true

class EventSerializer < Panko::Serializer
  attributes :id, :event_type, :name
end
