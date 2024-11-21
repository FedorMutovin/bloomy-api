# frozen_string_literal: true

class HobbySerializer < Panko::Serializer
  attributes :id, :name, :skill_level, :engagement_level, :initiated_at

  def initiated_at
    object.initiated_at&.utc&.iso8601
  end
end
