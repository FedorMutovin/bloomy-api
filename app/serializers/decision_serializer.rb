# frozen_string_literal: true

class DecisionSerializer < Panko::Serializer
  attributes :id, :name, :description, :initiated_at

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end
end
